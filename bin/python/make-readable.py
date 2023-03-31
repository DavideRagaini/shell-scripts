#!/usr/bin/env python3

import sys,requests
from os import environ
from readability import Document

if len(sys.argv) >2:
    print("Only need URL")
    # print("Second Arg need to be NAME; defaulting to output.html")
    exit(1)

input = sys.argv[1] #URL
# output_name = sys.argv[2]+".html"
print ('Input: ', input)
# print ('Output name: ', output_name)
response = requests.get(input)
doc = Document(response.content)
output_title = environ["HOME"] + "/Books/Kindle/WebPages/" + doc.title().strip().replace("/","-") + ".html"
print("Title: " + output_title)
output_file= open(output_title,"w+")
output_file.write(doc.summary())
output_file.close()
print ('Output file: ', output_file)

# import getopt
# def main(argv):
#    input_file = ''
#    output_file = ''
#    opts, args = getopt.getopt(argv,"hi:o:",["input=","output="])

#    for opt, arg in opts:
#       if opt == '-h':
#          print ('test.py -i <input_file> -o <output_file>')
#          sys.exit()
#       elif opt in ("-i", "--input"):
#          input_file = arg
#       elif opt in ("-o", "--output"):
#          output_file = arg

   # print ('Input file is ', input_file)
   # print ('Output file is ', output_file)
   # response = requests.get(input_file)
   # doc = Document(response.content)
   # print("Title: " + doc.title())
   # print(doc.summary())

# if __name__ == "__main__":
#    main(sys.argv[1:])
