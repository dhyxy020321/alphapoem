import os
import time

import requests
from flask import Flask, Response, json, jsonify, request
from alibabacloudnls.voice2str import TestSr
from duiduipeng import search

from nine_palaces import nine_palaces
from restful import process
from sarch_similar import similar_sarch
from search_poem import search_poem

app = Flask("alphapoems")


# 保存视频   文件放到body   文件名字放入header
@app.route('/getmp3', methods=['post'])
def getmp3():
    #取得音频
    data = request.files
    print(type(data))
    print(data)
    file = data['file']
    print(file.filename)
    path = "templates/"
    file.save(path + file.filename)

    audioFile = path + file.filename
    str=process(audioFile)     #获得转换文

    return json.dumps({'msg':'200','yuanju':str},ensure_ascii=False)




@app.route('/helloworld')
def hello():
    return 'hello world'

#九宫格    返回九字 和诗句
@app.route('/nine_palaces',methods=['GET'])
def nine_palace():
    a=nine_palaces()
    aa=a.output()
    # result= {'msg':'200','juanju':1,'jiuzi':2}
    return json.dumps({'msg':'200','yuanju':aa[0],'jiuzi':aa[1]},ensure_ascii=False)


#飞花令    接收一个字，搜寻 返回包含该字的一句诗
@app.route('/fly_flower',methods=['POST'])
def fly_flower():
    # str=request.args.get('word')
    data=request.get_data()
    data=json.loads(data)
    str=data['word']
    print(str)
    a=search_poem()
    output=a.find_one(str)
    time.sleep(2)
    return json.dumps({'msg':'200','yuanju':output},ensure_ascii=False)

#对对碰   三个字全搜索
@app.route('/duiduipeng',methods=['POST'])
def duidui_peng():
    # str=request.args.get('word')
    data=request.get_data()
    data=json.loads(data)
    str=data['word']
    print(str)


    a = search()
    a.word = str
    result = a.find()
    print(json.dumps(result, ensure_ascii=False, indent=2))
    return json.dumps({'content':result[0]}, ensure_ascii=False, indent=2)
    # return json.dumps({'msg':'200','content':result},ensure_ascii=False)

#大浪淘沙 诗句返回翻译
@app.route('/tao', methods=['POST'])
def tao():
    #取得音频
    data = request.files
    print(type(data))
    print(data)
    file = data['file']
    print(file.filename)
    path = "templates/"
    file.save(path + file.filename)

    audioFile = path + file.filename
    str=process(audioFile)     #获得转换文

    #搜索
    tt=similar_sarch()
    s = tt.find_poem(str)
    output=tt.return_meaning(s)   #得到返回
    print(output)

    return json.dumps({'msg':'200','output':output},ensure_ascii=False)


if __name__ == '__main__':
    # app.run(host='101.43.253.189', port=22, debug=True)
    app.run(host='0.0.0.0',port=22000, debug=True)