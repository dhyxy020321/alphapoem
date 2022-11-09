import random
import re
from pymongo import MongoClient


class nine_palaces:
    # 连接数据库
    client = MongoClient('', 27017,username='',password='')
    # 连接到数据库集合
    db = client['poem']['alphapoems']

    # # 连接数据库
    # client = MongoClient('localhost', 27017)
    # # 连接到数据库集合
    # db = client['Test']['poetry']

    # 所有数据
    result = list(db.find())

    map = []
    for i in result:
        map.append(i['content'])

    # 生成随机诗句
    def fun(self):
        x = random.randint(0, len(self.map) - 1)
        item = re.split(r'[，。！？]', self.map[x])
        y = random.randint(0, len(item) - 2)
        str = re.sub(u"\\(.*?\\)|\\{.*?}|\\[.*?]", "", item[y])  # 去掉括号内的内容
        str = str.strip()  # 去空格
        if len(str) < 5 or len(str) > 8 or str is None:  # 舍去4字以下8字以上诗句
            return self.fun()
        else:
            # print(str)
            return str

    # 生成九个字乱序诗句
    def shuffle_str(self, poem, ran):
        print(poem)
        print(ran)
        list_poem1 = list(poem)
        list_poem2 = random.sample(list(ran), 9 - len(poem))

        list_poem = list_poem1 + list_poem2
        random.shuffle(list_poem)

        return "".join(list_poem)

    def output(self):
        x1 = self.fun()
        x2 = self.fun()
        output = []
        output.append(x1)
        output.append(self.shuffle_str(x1, x2))
        return output


if __name__ == '__main__':
    a = nine_palaces()
    output = a.output()
    print(output[0])
    print(output[1])
