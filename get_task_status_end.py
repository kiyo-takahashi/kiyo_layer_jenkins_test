# -*- coding: utf-8 -*-
#
import os

dir_path = r'.'
file_name = 'tasks_status_log.txt'

file_path = os.path.join(dir_path, file_name)

with open(file_path) as f:
    lines = f.readlines()

#print(lines)

# endならTrue
wf_status = ['state: blocked' in lines or 'state: running' in lines or 'state: ready' in lines or 'state: retry_waiting' in lines]

print(wf_status)

