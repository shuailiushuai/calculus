import os
from datetime import datetime

header_snippet = '''
#import "./template.typ": *
#import "@preview/xarrow:0.3.0": xarrow

#show: project.with(
  course: "Calculus II",
  course_fullname: "Calculus (A) II",
  course_code: "821T0160",
  semester: "Spring-Summer 2024",
  title: "%s",
  authors: (
    (
      name: "memset0",
      email: "memset0@outlook.com",
      id: "3230104585",
    ),
  ),
  date: "%s",
)
'''

reset_snippet = '''
#let alpha = math.alpha
#let beta = math.beta
#let gamma = math.gamma
#let theta = math.theta
#let eta = math.eta
#let nu = math.nu
#let xi = math.xi
#let Lambda = math.Lambda
'''


def process(content):
    start_pos = content.find('#show: project.with')

    if start_pos != -1:
        open_brackets = 0
        close_brackets = 0
        end_pos = None
        for i in range(start_pos, len(content)):
            if content[i] == '(':
                open_brackets += 1
            elif content[i] == ')':
                close_brackets += 1
            if open_brackets == close_brackets and open_brackets > 0:
                end_pos = i
                break
        if end_pos is not None:
            content = content[end_pos+1:]

    content = reset_snippet + content
    return content


def build(title, source_folder, target_file):
    script_dir = os.path.dirname(os.path.realpath(__file__))
    source_dir = os.path.join(script_dir, source_folder)
    all_content = header_snippet % (title, datetime.today().strftime("%B %d, %Y"))
    for filename in os.listdir(source_dir):
        file = os.path.join(source_dir, filename)
        if os.path.isfile(file) and filename.endswith('.typ'):
            with open(file, 'r', encoding='utf8') as file:
                content = process(file.read())
                all_content += content
    all_content = all_content.replace('image("images/', f'image("{source_folder}/images/')

    distfile = os.path.join(script_dir, target_file)
    with open(distfile, 'w', encoding='utf8') as file:
        file.write(all_content)
    os.system(f'typst compile {distfile}')


build('微积分（甲）Ⅰ学习笔记', 'note-1',  '微积分1笔记.typ')
build('微积分（甲）Ⅱ学习笔记', 'note-2',  '微积分2笔记.typ')
