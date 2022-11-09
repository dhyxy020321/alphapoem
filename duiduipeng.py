from pymongo import MongoClient


class search:
    word = ""
    result_poem = []
    # 连接数据库
    db = MongoClient('101.43.253.189', 27017, username='admin', password='1833815177')['poem']['alphapoems']

    # db = MongoClient('localhost', 27017)['Test']['poetry']

    def find_word3_content(self, w1, w2, w3):
        result3 = []
        content = list(self.db.find({'$and': [{"content": {"$regex": w1}}, {"content": {"$regex": w2}},
                                              {"content": {"$regex": w3}}]}, {"content": 1, "_id": 0}))
        for i in content:
            for key, value in i.items():
                result3.append(value.strip())
        result3.sort(key=lambda x: len(x))
        return result3

    def find_word2_content(self, w1, w2, w3):
        result2 = []
        content = list(self.db.find({'$and': [{"content": {"$regex": w1 + "|" + w2}}, {"content": {"$regex": w3}}]},
                                    {"content": 1, "_id": 0}))
        content.extend(list(self.db.find({'$and': [{"content": {"$regex": w1}}, {"content": {"$regex": w2}}]},
                                         {"content": 1, "_id": 0})))
        for i in content:
            for key, value in i.items():
                result2.append(value.strip())
        result2.sort(key=lambda x: len(x))
        return result2

    def find(self):
        w = list(self.word)
        w1, w2, w3 = w[0], w[1], w[2]

        result_word3_content = self.find_word3_content(w1, w2, w3)
        if result_word3_content:
            return result_word3_content
        else:
            result_word2_content = self.find_word2_content(w1, w2, w3)
            if result_word2_content:
                return result_word2_content
            else:
                return None


if __name__ == '__main__':
    a = search()
    a.word = input()
    result = a.find()
    print(result)
    # print(result[0])
# 秋叶水  十年长
