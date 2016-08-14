import re
import pandas as pd
import sys
import shutil

def remove_unicode(replace_or_list, filename):
    unicodes = {'ö': '\\"{o}',
                '–': '-',
                'ø': '{\o}'}

    with open(filename,'rt') as file:
        lines = file.readlines()
    with open(filename,'rt') as file:
        wholefile = file.read()
    if replace_or_list == 1:
        print("Ok. Just listing for now...")
        print('If you replace, the following changes will be made...')
        for line in lines:
            m = re.match('(.*author\s*=\s*\{(.*)\}\s*,)',line.rstrip())
            if m != None:
                author_line = m.group(1)
                author_names = m.group(2)
                for bad_char in unicodes.keys():
                    if(bad_char in author_names):
                        newname = re.sub(bad_char, unicodes[bad_char], author_names)
                        print('\t',author_names.ljust(55),"------->\t\t",newname)
    elif replace_or_list == 2:
        print("Ok. Replacing... and making a backup file .bak2")
        print("...............................................")
        shutil.copy2(filename, filename+'.bak2')
        print("Now replacing.")
        newfile = wholefile
        for bad_char in unicodes.keys():
            newfile = re.sub(bad_char, unicodes[bad_char], newfile)
        with open(filename, 'wt') as out:
            out.write(newfile)




def abbreviateit(replace_or_list, filename):
    '''
    Martin Forsythe wrote this in 2015
    '''
    df = pd.read_csv('Master_Journal_Abbreviations',sep='\t',index_col=0)
    journal_dict = df['abbrev'].to_dict()

    with open(filename,'rt') as file:
        lines = file.readlines()
    with open(filename,'rt') as file:
        wholefile = file.read()

    if replace_or_list == 1:
        print("Ok. Just listing for now...")
        print('If you replace, the following changes will be made...')
        for line in lines:
            m = re.match('(.*journal\s*=\s*\{(.*)\}\s*,)',line.rstrip())
            if m!=None:
                journal_line = m.group(1)
                journal = m.group(2)

                journal_key = re.sub('^The ','',journal)

                if journal_key in journal_dict.keys():
                    abbrev = journal_dict[journal_key]
                    print('\t',journal.ljust(55),"------->\t\t",abbrev)

    elif replace_or_list == 2:
        print("Ok. Replaceing... and making a backup file .bak")
        print("...............................................")
        shutil.copy2(filename, filename+'.bak')
        print("Now replacing.")
        newfile = re.sub('The Journal', 'Journal', wholefile)
        for journal_key in journal_dict.keys():
            newfile = re.sub(journal_key, journal_dict[journal_key], newfile)
        with open(filename, 'wt') as out:
            out.write(newfile)
        print("After replacement your bibliography contains the following journals:")
        list_of_journals = []
        for line in lines:
            m = re.match('(.*journal\s*=\s*\{(.*)\}\s*,)',line.rstrip())
            if m!=None:
                journal_line = m.group(1)
                journal = m.group(2)
                list_of_journals.append(journal)
        for j in set(list_of_journals):
            print ('\t',j)


def check_for_no_doi(filename):
    with open(filename,'rt') as file:
        lines = file.readlines()
    linenumber = -1
    entry_key_linenumbers = []
    entry_types = []
    cite_keys = []
    for line in lines:
        linenumber+=1
        if re.match('\s*@\w*',line) != None:
            entry_type = line.split('{')[0]
            cite_key = line.split('{')[1].rstrip(',\n')
            entry_key_linenumbers.append(linenumber)
            cite_keys.append(cite_key)
            entry_types.append(entry_type)

    df = pd.DataFrame()
    df['type'] = entry_types
    df['cite_key'] = cite_keys
    df['start'] = entry_key_linenumbers
    df['end'] = entry_key_linenumbers[1:len(entry_key_linenumbers)]+[len(lines)]

    doi_list = []
    url_present_list = []
    for id in df.index.values:
        entry_lines = lines[df.loc[id]['start']:df.loc[id]['end']]
        url_present = False
        doi = ''
        for line in entry_lines:
            if re.match('\s*doi',line) !=None:
                doi = line.split('{')[1].split('}')[0]
            if re.match('\s*url',line)!=None:
                url_present = True
        url_present_list.append(url_present)
        doi_list.append(doi)
    df['url'] = url_present_list
    df['doi'] = doi_list
    df.sort(['type','doi','cite_key'],inplace=True)
    # print df[['cite_key','doi']]

    # PRINT OUT REPEATED DOIs:

    problems = df.copy()
    problems = problems[problems['type']=='@article']
    problems = problems[problems['doi']=='']
    print(problems)

def check_for_dupes(filename):
    with open(filename,'rt') as file:
        lines = file.readlines()
    linenumber = -1
    entry_key_linenumbers = []
    entry_types = []
    cite_keys = []
    for line in lines:
        linenumber+=1
        if re.match('\s*@\w*',line) != None:
            entry_type = line.split('{')[0]
            cite_key = line.split('{')[1].rstrip(',\n')
            entry_key_linenumbers.append(linenumber)
            cite_keys.append(cite_key)
            entry_types.append(entry_type)

    df = pd.DataFrame()
    df['type'] = entry_types
    df['cite_key'] = cite_keys
    df['start'] = entry_key_linenumbers
    df['end'] = entry_key_linenumbers[1:len(entry_key_linenumbers)]+[len(lines)]

    doi_list = []
    url_present_list = []
    for id in df.index.values:
        entry_lines = lines[df.loc[id]['start']:df.loc[id]['end']]
        url_present = False
        doi = ''
        for line in entry_lines:
            if re.match('\s*doi',line) !=None:
                doi = line.split('{')[1].split('}')[0]
            if re.match('\s*url',line)!=None:
                url_present = True
        url_present_list.append(url_present)
        doi_list.append(doi)
    df['url'] = url_present_list
    df['doi'] = doi_list
    df.sort(['type','doi','cite_key'],inplace=True)
    problems = df.copy()
    problems = problems[problems['doi']!='']
    ids = problems["doi"]
    print(problems[ids.isin(ids[ids.duplicated()])].sort("doi")[['cite_key','doi']])


if __name__ == "__main__":
    if len(sys.argv)!=2:
        print("Please provide input arguments. \n" \
              "Example usage: python Abbreviabibtex.py bibliography.bib \n" \
              "The program will then query you for 'replace' or 'list' \n")
        exit()
    bibfile = sys.argv[1]
    replace_or_list = int(input("Should I make replacements or list possible ones? [options: 0 to skip, 1 to list, 2 to replace]: "))
    if(replace_or_list != 0):
        abbreviateit(replace_or_list, bibfile)

    check_no_dois = int(input("Should I check for missing DOIs? [options: 0 to skip, 1 to check]: "))
    if(check_no_dois == 1):
        check_for_no_doi(bibfile)

    check_dupes = int(input("Should I check for duplicate entries? [options: 0 to skip, 1 to check]: "))
    if(check_no_dois == 1):
        check_for_dupes(bibfile)

    check_unicode = int(input("Should I replace or list unicode characters? [options: 0 to skip, 1 to list, 2 to replace]: "))
    if(replace_or_list != 0):
        remove_unicode(check_unicode, bibfile)


