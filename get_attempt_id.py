# -*- coding: utf-8 -*-
#
import os

dir_path = r'.'
file_name = 'session_attempt_exec_log.txt'

file_path = os.path.join(dir_path, file_name)

with open(file_path) as f:
    lines = f.readlines()

#print(lines)

# 改行コードを削除
lines_strip = [line.strip() for line in lines]

list_attempt_id = [line_s for line_s in lines_strip if 'attempt id' in line_s]
#print(list_attempt_id)

attempt_id = list_attempt_id[0].split()[2]

print(attempt_id)

