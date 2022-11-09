import re
import difflib
from pymongo import MongoClient
from bson.objectid import ObjectId

# 连接数据库
client = MongoClient('localhost', 27017)
# 连接到数据库集合
db = client['Test']['poetry']
# 所有数据
result = list(db.find())

keys = []
values = []
for i in result:
    keys.append(str(i['_id']))
    values.append(i['content'])
map = dict(zip(keys, values))


# # 读取excel表格形成字典
# df = pd.read_excel(r'E:/sj.xlsx')
# map = dict(zip(df['id'],df['content']))

# 返回字符串相似度
def string_similar(s1, s2):
    return difflib.SequenceMatcher(None, s1, s2).quick_ratio()


# 根据key值输出诗句的各种信息
def findone(id):
    return list(db.find({"_id": ObjectId(id)}))


def poemname(id):
    for i in findone(id):
        print("poemname :", i['poemname'])


def dynasty(id):
    for i in findone(id):
        print("dynasty :", i['dynasty'])


def author(id):
    for i in findone(id):
        print("author :", i['author'])


def content(id):
    for i in findone(id):
        print("content :", i['content'])


def label(id):
    for i in findone(id):
        print("label :", i['label'])


def translate(id):
    for i in findone(id):
        print("translate :", i['translate'])


def notes(id):
    for i in findone(id):
        print("notes :", i['notes'])


def appreciation(id):
    for i in findone(id):
        print("appreciation :", i['appreciation'])


# 任给9个字从中找到一句诗
def jgg(str):
    b = 0  # 初始相似度
    for i in map:
        item2 = re.split(r'[，。！？]', map[i])
        for y in item2:
            y = y.strip()  # 去除前后空格
            if len(y) > 4:
                a = string_similar(y, str)
                if a > b:
                    b = a
                    str1 = y
                    key = i

    for k in str1:
        str = str.replace(k, '', 1)
    if len(str) == 9 - len(str1):
        return str1, key
    else:
        return 0


regex = re.compile('[\u4e00-\u9fa5]{9}')  # 正则
str = input('输入九个汉字： ')
if regex.search(str) is None or len(str) != 9:
    print("输入格式不符")
else:
    c, key = jgg(str)
    if c == 0:
        print("未找到符合的诗句")
    else:
        print(c)
        poemname(key)
        dynasty(key)
        author(key)
        content(key)
        label(key)
        translate(key)
        notes(key)
        appreciation(key)
