# m=input()
# n=m.split(" ")
# for item in n:
#     if len(item)==3:
#         print(item)

# m=input()
# f = open('test.txt', 'w')
# f.write(m)
# f.close() # 需要关闭打开的文件
#
# with open('test.txt', 'r') as f:
#     data=f.read()
#     print(data)

# list1=input().split(" ")
# list2=input().split(" ")
# dict={}
# for i in range(len(list1)):
#     dict[list1[i]]=list2[i]
#
# print(dict)


# def ou(id,name,age):
#     dict={'学号':id,'姓名':name,'年龄':age}
#     print(dict)
#
# ou(123,'zhangsan',24)


# message={"header":{"namespace":"SpeechRecognizer","name":"RecognitionCompleted","status":20000000,"message_id":"290652ad041343809be5e99985010259","task_id":"586c2b3a0b44461d84ef9d406a158125","status_text":"Gateway:SUCCESS:Success."},"payload":{"result":"北京科技馆","duration":2020}}
# # print(message['payload']['result'])
# # print(message['payload'].get('result'))
#
# print("{}".format(message))
# print(type(message))

# from dataset.mnist import load_mnist

a=200
def test():
    global  a
    print(a)
    a=400
    print(a)

test()
print(a)