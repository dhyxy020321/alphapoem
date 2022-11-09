# -*- coding: utf-8 -*-
"""
@Author  : ljg
@Date: 2022/9/22 16:15
"""
import re
from pymongo import MongoClient
from bson.objectid import ObjectId


class search_all:
    # 连接数据库
    client = MongoClient('101.43.253.189', 27017,username='admin',password='1833815177')
    # 连接到数据库集合
    db = client['poem']['alphapoems']
    # 所有数据
    result = list(db.find())

    word = ""

    def find(self,word):
        output = []
        for i in range(0, len(self.result)):
            if (self.result[i]['poemname'] is not None and self.word in self.result[i]['poemname']) or \
                    (self.result[i]['dynasty'] is not None and self.word in self.result[i]['dynasty']) or \
                    (self.result[i]['author'] is not None and self.word in self.result[i]['author']) or \
                    (self.result[i]['content'] is not None and self.word in self.result[i]['content']) or \
                    (self.result[i]['label'] is not None and self.word in self.result[i]['label']) or \
                    (self.result[i]['translate'] is not None and self.word in self.result[i]['translate']) or \
                    (self.result[i]['notes'] is not None and self.word in self.result[i]['notes']) or \
                    (self.result[i]['appreciation'] is not None and self.word in self.result[i]['appreciation']):
                output.append(self.result[i])
        return output


if __name__ == '__main__':
    str_word = input('输入:')
    a = search_all()
    poetry = a.find(str_word)
    print(poetry[0])
