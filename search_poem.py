# -*- coding: utf-8 -*-
"""
@Author  : ljg
@Date: 2022/9/27 17:44
"""
import re

import zhon.hanzi
from pymongo import MongoClient
from bson.objectid import ObjectId
import random

#返回一个诗句  飞花令
class search_poem:
    # 连接数据库
    client = MongoClient('101.43.253.189', 27017,username='admin',password='1833815177')
    # 连接到数据库集合
    db = client['poem']['alphapoems']

    # 所有数据
    result = list(db.find())


    keys = []
    values = []
    for i in result:
        values.append(i['content'])

    def find_one(self, word):
        output = []

        for value in self.values:
            if value is not None and word in value:
                output.append(value)
        i=len(output)
        num=random.randint(0,i)

        poetry=output[num]
        poem = re.findall(zhon.hanzi.sentence, poetry)
        for verse in poem:
            if word in verse:
                return verse

        return output[num]


if __name__ == '__main__':
    a = search_poem()
    word = '风'
    poem = a.find_one(word)
    print(poem)
