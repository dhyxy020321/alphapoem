
from difflib import SequenceMatcher
from random import random

from pymongo import MongoClient


class similar_sarch:
    # 连接数据库
    client = MongoClient('101.43.253.189', 27017, username='admin', password='1833815177')
    # 连接到数据库集合
    db = client['poem']['alphapoems']

    # 所有数据
    result = list(db.find())

    values = []
    meaning=[]
    for i in result:
        values.append(i['content'])
        meaning.append(i['translate'])

    def find_poem(self, word):
        for i in self.result:
            if i['content'] is None:
                # ze=random.randint(1,100)
                return self.result[2]

            if SequenceMatcher(None, i['content'], word).ratio()>0.10:
                return i



    # def return_poem(self, i):
    #     return i['content']

    def return_meaning(self, i):
        return i['translate']




if __name__ == '__main__':
    a = "胡笳一声愁绝"
    # a = "北京科技馆。"
    tt=similar_sarch()
    s = tt.find_poem(a)
    # print(s)
    # print(tt.return_poem(s))
    print(tt.return_meaning(s))
    # print(s.ratio())
