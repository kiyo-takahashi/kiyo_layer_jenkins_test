# -*- coding: utf-8 -*-
#
import os

dir_path = r'.'
file_name = 'tasks_status_log.txt'

file_path = os.path.join(dir_path, file_name)

with open(file_path) as f:
    lines = f.readlines()

#print(lines)

# 実行中のステータスが検出されたら、tasks_in_progressリストに該当行を出力
tasks_in_progress = [line for line in lines if 'state: planned' in line or 'state: blocked' in line or 'state: running' in line or 'state: ready' in line or 'state: retry_waiting' in line]
#print(tasks_in_progress)

# tasks_in_progressリストの長さが0なら、実行中タスクが無いと判断しEndとする
if len(tasks_in_progress) == 0:
    wf_status = "End"
else:
    wf_status = "Running"

print(wf_status)

