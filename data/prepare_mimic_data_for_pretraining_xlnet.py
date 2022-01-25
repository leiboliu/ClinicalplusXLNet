# Please change the relevant configurations in the codes.

import os
import re

from nltk.tokenize import sent_tokenize

def get_connection():
    global conn
    if conn is None:
        conn = psycopg2.connect(dbname="test", user="test", password="test",
                                host="localhost", options=f'-c search_path=mimiciii')
    return conn


def prepare_data_for_xlnet_lm(database_conn, query_statement, output_file,
                              force_split_text_to_sent=True, preprocessing=True, lowercase=True):
    parent_dir = os.path.dirname(output_file)
    if not os.path.exists(parent_dir):
        os.makedirs(parent_dir)

    if os.path.isdir(output_file):
        output_file = os.path.join(output_file, "sentences_for_xlnet_lm.txt")

    cur = database_conn.cursor()
    cur.execute(query_statement)
    text_no = 0
    sent_no = 0

    # tokenize text to sentences and output into file
    with open(output_file, 'w', newline='\n') as f:
        for text in cur:
            if text[0] is not None:
                doc = " ".join(text[0].split())
                sents = sent_tokenize(doc) if force_split_text_to_sent else [doc]
                for sent in sents:
                    if lowercase:
                        sent = sent.lower()
                    if preprocessing:
                        # 1. no word context, single word sentence
                        if len(sent.split()) < 2:
                            continue
                        # 2. remove underscore character
                        sent = re.sub('--|__|==', '', sent)
                        # 3. remove de-identified brackets
                        sent = re.sub('\\[(.*?)\\]', '', sent)

                    f.write(sent)
                    f.write('\n')
                    sent_no += 1
                f.write('\n')
                text_no += 1

                if text_no % 100 == 0:
                    print("{} documents dumped".format(text_no))

    print("Data export done for '{}' to the file '{}'".format(query_statement, output_file))
    return


conn = get_connection()
# transform MIMIC III notes
# Mimic III all clinical notes
outfile = '../../data/lm_mimiciii/mimiciii_uncased_sentences_preprocessed_total.txt'
select_statement = "select text from mimiciii.noteevents"
prepare_data_for_xlnet_lm(conn, select_statement, outfile)
# #
outfile = '../../data/lm_mimiciii/mimiciii_uncased_sentences_preprocessed_total-ds.txt'
select_statement = "select text from mimiciii.noteevents where category <> 'Discharge summary'"
prepare_data_for_xlnet_lm(conn, select_statement, outfile)

