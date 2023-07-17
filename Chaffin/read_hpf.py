
import os
import numpy as np
import array
import datetime
from pandas.plotting import register_matplotlib_converters
register_matplotlib_converters()


class Hpf():
    chan_info_lst = ['Name', 'Unit', 'ChannelType', 'AssignedTimeChannelIndex', 'DataType',
                    'DataIndex', 'StartTime', 'TimeIncrement', 'RangeMin', 'RangeMax',
                    'DataScale', 'DataOffset', 'SensorScale', 'SensorOffset',
                    'PerChannelSampleRate', 'PhysicalChannelNumber']

    @staticmethod
    def parse_header(f, pos, off):
        creator_ID = f.read(4).decode('CP437') #CP347 to decode the char data on this file. :-) IBM
        # print('creator_ID:', creator_ID)
        file_version =  int.from_bytes(f.read(8), byteorder='little')
        # print('File Version:', file_version)
        index_chunk_offset =  int.from_bytes(f.read(8), byteorder='little')
        # print('index chunk offset:', index_chunk_offset)
        XML_data = f.read(off - (f.tell()-pos)).decode('CP437')
        # print('xml data has length:', len(XML_data))
        start = XML_data.find('<RecordingDate>')
        stop = XML_data.find('</RecordingDate>')
        fdt = XML_data[start +15: stop-1];
        fdt = datetime.datetime.strptime(fdt, '%Y/%m/%d %H:%M:%S.%f')
        # print('RecordingDate:', fdt)
        return creator_ID, file_version, index_chunk_offset, fdt

    @staticmethod
    def parse_chan_inf(f, pos, off):
        group_ID = int.from_bytes(f.read(4), byteorder='little')
        # print('group ID:', group_ID)
        num_channels = int.from_bytes(f.read(4), byteorder='little')
        # print('num_channels:', num_channels)
        # print( 'off = {}, f.tell()={}, pos = {}'.format(off, f.tell(), pos))
        XML_data = f.read(off - (f.tell()-pos)).decode('CP437')
        # print('xml data has length:', len(XML_data))
        idx = 0
        chan_info = []
        for i in range(num_channels):
            chan_dict={}
            # print('********** Information for channel {} ***********'.format(i+1))
            for info_str in Hpf.chan_info_lst:
                start = XML_data.find('<'+info_str+'>', idx)
                stop = XML_data.find('</'+info_str+'>', idx)

                inf = XML_data[start +len(info_str)+2: stop];
                idx = stop
                chan_dict[info_str] = inf
            chan_info.append(chan_dict)
        return num_channels, chan_info

    @staticmethod
    def parse_data(f, chan_data):
        group_ID = int.from_bytes(f.read(4), byteorder='little')
        # print('groupID: {}'.format(group_ID))
        data_start_idx = int.from_bytes(f.read(8), byteorder='little')
        # print('data start index = {}'.format(data_start_idx))
        chan_data_count = int.from_bytes(f.read(4), byteorder='little')
        # print('chan data count = {}'.format(chan_data_count))
        arr = np.zeros((chan_data_count, 2), dtype='int')
        for count in range(chan_data_count):
            arr[count, 0] = int.from_bytes(f.read(4), byteorder='little') # channel Offset
            arr[count, 1] = int.from_bytes(f.read(4), byteorder='little') # channel length

        pos = f.tell() # needs to use the offset from the same start position for each channel.
        for count in range(chan_data_count):
            f.seek(arr[count, 0] -(32 +8*chan_data_count) + pos)
            dat = array.array('d',f.read(arr[count,1]))
            chan_data[count].append(dat)
        return chan_data

    def __init__(self, fname, creator_ID, fdt, num_channels, chan_info, data):
        self.fname = fname
        self.creator_ID = creator_ID
        self.fdt = fdt
        self.num_channels = num_channels
        self.chan_info = chan_info
        self.data = data

    @classmethod
    def init_from_hpf(cls, fname):
        pos = 0
        with open(fname, 'rb') as f:
            while True:
                chunkID = int.from_bytes(f.read(8), byteorder='little')
                off = int.from_bytes(f.read(8), byteorder='little')
                # print('file place index = {}, off = {}, chunkID = {}'.format(f.tell(), off, chunkID))
                if chunkID == 4096: # Header chunk ID 0x1000
                    # print('Parsing Header information')
                    creator_ID, file_version, index_chunk_offset, fdt = Hpf.parse_header(f, pos, off)

                elif chunkID == 8192: # Channel Information chunk ID 0x2000
                    # print('Parsing channel information')
                    num_channels, chan_info = Hpf.parse_chan_inf(f, pos, off)
                    chan_data = [[] for i in range(num_channels)]
                elif chunkID == 16384: #  chunk ID 0x4000 not expected
                    print('In event definition chunk')
                elif chunkID == 20840: # Chunk ID 0x5000 not expected
                    print('In event data chunk')
                elif chunkID == 24576: # ChunkID 0x6000 not always present
                    print('In Index chunk')
                elif chunkID == 28672: # Chunk ID 0x7000 ? not in documentation.
                    # print('In undocumented part')
                    f.seek(f.tell()+7)

                elif chunkID == 12288: # Chunk ID 0x3000
                    chan_data = Hpf.parse_data(f, chan_data)
                elif chunkID == 32768: # Chunk ID 0x8000
                    print('In undocumented part')
                    # f.seek(f.tell()+7)
                elif chunkID == 36864: # Chunk ID 0x9000
                    print('In undocumented part')
                    # f.seek(f.tell()+7)
                elif chunkID == 40960: # Chunk ID 0xA000
                    print('In undocumented part')
                    # f.seek(f.tell()+7)
                else:
                    # print('at end of if statements, chunk ID = ',chunkID)
                    break

                f.seek(off + pos)
                pos = f.tell()

            data_arr = [np.concatenate(x) for x in chan_data] # list of long arrays
            data_arr = np.array(data_arr).T
            #one per channel
            return Hpf(fname, creator_ID, fdt, num_channels, chan_info, data_arr)


def write_info_and_csv_from_hpf(filename, output_filename=None):
    """
    driver program, takes in file name (and path), makes hpf object from file,
    writes info to an info text file, and single or multichannel data to single
    or multi column data in a csv file.
    if output_filename is None, will write both txt and csv files with the same
    name as the hpf file.
    if there is a name given, then that name with the extensions will be used
    #TODO output multichannel data as columns, easy to do as rows, i don't have
    the data to test multichannel output.
    """
    hpf = Hpf.init_from_hpf(filename)
    if output_filename ==None:
        out_txt = filename[:-4]+'_info.txt'
        out_csv = filename[:-4]+'_data.csv'
    else:
        out_txt = output_filename+'_info.txt'
        out_csv = output_filename+'_data.csv'
    with open(out_txt, 'w') as f:
        f.write('filename: \t {} \n'.format(filename))
        f.write('creator ID: \t {} \n'.format(hpf.creator_ID))
        f.write('file date time: \t {} \n'.format(hpf.fdt))
        f.write('number of channels: \t {} \n'.format(hpf.num_channels))
        for chan in range(hpf.num_channels):
            f.write('********** Information for channel {} **********\n'.format(chan+1))
            for key in hpf.chan_info[chan]:
                f.write(key + ':\t' + hpf.chan_info[chan][key] + '\n')
    header = ''.join(['channel {}, '.format(x+1)  for x in range(hpf.num_channels)])
    header = header[:-2]+'\n'


    n,c = hpf.data.shape

    with open(out_csv,'w') as f:
        f.write(header)
        for i in range(n):
            dat = ''.join(['%0.8f, '])*c%tuple(hpf.data[i,:])
            dat = dat[:-3]+'\n'
            f.write(dat)

if __name__ == '__main__':
    filename = os.path.expanduser('~') +'/Data/ping/Tool steel/210518_BK_hard_0/210518_BK_hard_0_1_100-15.hpf'
    write_info_and_csv_from_hpf(filename)
