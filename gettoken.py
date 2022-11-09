#! /usr/bin/env python
# coding=utf-8
import os
import time
import json
from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.request import CommonRequest

def gettoken():
   # 创建AcsClient实例
   client = AcsClient(
      "",
      "",
      ""
   )

   # 创建request，并设置参数。
   request = CommonRequest()
   request.set_method('POST')
   request.set_domain('nls-meta.cn-shanghai.aliyuncs.com')
   request.set_version('2019-02-28')
   request.set_action_name('CreateToken')

   response = client.do_action_with_exception(request)
   print(response)

   jss = json.loads(response)

   token = jss['Token']['Id']
   expireTime = jss['Token']['ExpireTime']
   print("token = " + token)
   print("expireTime = " + str(expireTime))
   return token



if __name__ == '__main__':
   gettoken()
   # print(gettoken())
   # print(24*60*60)
   # print(1667481519/86400)


