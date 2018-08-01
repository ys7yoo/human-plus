import pandas as pd


def parseChannelInfo(chStr):
    """
    Parse channel number string

    Input chString can be a single number (e.g. "1") or a range (e.g. "13-14").
    """

    idx = chStr.find('-')
    if idx == -1: # single number
        ch = int(chStr)
        #print(ch)

        return ch, ch

    else:
        ch1 = int(chStr[:idx])
        ch2 = int(chStr[idx+1:])
        #print(ch1, ch2)

        return ch1, ch2

def loadChannelInfo(csvFilename):

    # read the csv file
    CHANNEL = pd.read_csv(csvFilename)
    #CHANNEL.info()

    # parse each row
    dictChannelLabel = dict()

    for idx in range(len(CHANNEL)):
        channel, region, label = CHANNEL.iloc[idx]

        # remove empty space
        channel = channel.strip()
        region = region.strip()
        label = label.strip()
        #print(channel, region, label)
        #print(label)

        #dictChannelLabel.update({channel:label})


        ch1, ch2 = parseChannelInfo(channel)
        #print(ch1, ch2)

        for ch in range(ch1, ch2+1):
            #print(ch)
            dictChannelLabel.update({ch:label})

    return dictChannelLabel
