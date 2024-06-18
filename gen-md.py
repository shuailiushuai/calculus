import os
import re
import shutil
import subprocess

os.chdir(os.path.dirname(os.path.abspath(__file__)))


def read_file(file):
    with open(file, 'r+', encoding='utf8') as f:
        return f.read()


def write_file(file, content):
    if not os.path.exists(os.path.dirname(file)):
        os.makedirs(os.path.dirname(file))
    with open(file, 'w+', encoding='utf8') as f:
        f.write(content)


def copy_file(source_file, target_file):
    if not os.path.exists(os.path.dirname(target_file)):
        os.makedirs(os.path.dirname(target_file))
    shutil.copy2(source_file, target_file)


typst_template = read_file('template.typ')
typst_functions = read_file('functions.typ')


def convert_pandoc(source):
    import pypandoc
    typst_pandoc_pre = read_file('pandoc-pre.typ')
    typst_pandoc_post = read_file('pandoc-post.typ')

    def line_filter(line):
        if line.startswith('#import '):
            return False
        if line.startswith("#include "):
            return False
        return True

    content = '\n\n\n'.join([
        typst_pandoc_pre,
        typst_template,
        typst_functions,
        typst_pandoc_post,
        source,
    ]).split('\n')
    content = filter(line_filter, content)
    content = '\n'.join(content)

    # print(content)
    write_file('tmp/gen-md-middle.typ', content)

    result = pypandoc.convert_text(
        content,
        'markdown',
        format='typst',
    )
    result = result.replace('\r', '')
    result = result.replace(r'\n', '')
    write_file('tmp/gen-md-result.md', result)
    return result


def gen_md(source, slug, frontmatter=dict(), target_dir='tmp'):
    print('generating...', slug, frontmatter)
    if slug.startswith('/'):
        slug = slug[1:]

    typst_header_pre = read_file('convert-svg-pre.typ')
    typst_header_post = read_file('convert-svg-post.typ')
    typst_slot_before_body = read_file('convert-svg-slot-before-body.typ')

    content = '\n\n\n'.join([
        typst_header_pre,
        typst_template,
        typst_functions,
        typst_header_post,
        source,
    ])
    content = content.replace('/* { slot: before-body } */',  typst_slot_before_body)

    lines = []
    headings = []
    for line in content.split('\n'):
        if line.startswith('#pagebreak('):
            continue
        if line.startswith('#import ') and not line.startswith('#import "@preview/'):
            continue
        if line.startswith('#include ') and not line.startswith('#include "@preview/'):
            continue
        if re.match(r'^={1,3} ', line) is not None:
            level = len(re.match(r'^={1,3} ', line)[0]) - 1
            title = line[level + 1:]
            headings.append([level, title, False])
            lines.append('#pagebreak(weak: false)')
            lines.append(line)
            lines.append('#pagebreak(weak: false)')
            continue
        if len(line.strip()) > 0 and len(headings) > 0:
            headings[-1][2] = True
        lines.append(line)

    content = '\n'.join(lines)

    def generate_size(device, width):
        write_file('tmp/content.typ', content.replace('/* slot: page-width */', width))
        if not os.path.exists(f'tmp/{device}'):
            os.makedirs(f'tmp/{device}')
        commands = ['typst', 'compile', '-f', 'svg', 'tmp/content.typ', f'tmp/{device}/page-{{n}}.svg']
        process = subprocess.Popen(commands, stdout=subprocess.PIPE)
        output, error = process.communicate()
        if output:
            print(output)
        if error:
            raise Exception(error)

    generate_size('mobile', '300pt')
    generate_size('desktop', '600pt')

    counter = [0, 0, 0, 0]
    result = '---\n'
    for key in frontmatter:
        result += f'{key}: {frontmatter[key]}\n'
    result += '---\n\n'
    for i in range(len(headings)):
        level = headings[i][0]
        title = headings[i][1]
        has_content = headings[i][2]
        page = '%02d' % (i * 2 + 3)
        copy_file('tmp/desktop/page-%s.svg' % page, f'{target_dir}/assets/{slug}/desktop/page-{page}.svg')
        copy_file('tmp/mobile/page-%s.svg' % page, f'{target_dir}/assets/{slug}/mobile/page-{page}.svg')
        counter[level - 1] += 1
        for i in range(level, len(counter)):
            counter[i] = 0
        result += '#' * (level + 1) + ' '
        for i in range(0, level):
            result += str(counter[i]) + '.'
        result += ' ' + title + '\n\n'
        if has_content:
            result += '<picture>'
            result += f'<source media="(min-width:600px)" srcset="./desktop/page-{page}.svg">'
            result += f'<img src="./mobile/page-{page}.svg" alt="part #{page}">'
            result += '</picture>\n\n'

    write_file(os.path.join(target_dir, f'{slug}.md'), result)


if __name__ == '__main__':
    # target_dir = os.environ['GATSBY_SOURCE']
    target_dir = "E:\Git\gatsby-blog\content"
    for task in read_file('gen-md.csv').split('\n'):
        source_file, slug, title = task.split('\t')
        gen_md(read_file(source_file), slug, dict(title=title), target_dir)
