#!/usr/bin/env python
# coding: utf-8

#anaconda 프롬프트 창을 켜서 해당 파일이 있는 주소로 경로 이동(cd)
# 실행명령어 uvicorn main:app --reload

# # 필요한 라이브러리 설치

# - fastapi : python 쪽에 요청을 처리할 수 있는 서버를 로드할 수 있는 라이브러리 (flask 라이브러리 유사)
# - uvicorn : 서버 재요청을 할 때마다, 서버를 껐다 켜는 게 불편하니까 사용하기 쉬우려고 추가하는 라이브러리

# 동일출처 정책을 풀어줄 수 있는 설정을 잡아보자 
from fastapi.middleware.cors import CORSMiddleware
from selenium import webdriver as wb
from selenium.webdriver.common.by import By


# In[1]:


# get_ipython().system(' pip install fastapi')


# In[2]:


# get_ipython().system('pip install uvicorn[standard]')


# # FastAPI 사용하기

# In[4]:


# 1. 라이브러리 가져오기
from fastapi import FastAPI


# In[6]:


# get_ipython().system('pip install nbconvert')


# In[5]:
#크롤링 함수 --> 저런 코드들을 다 가지고 있는 모듈화 해보기
#2. 크롬창 띄우기 
def crawling(search) : 
    driver = wb.Chrome()
    url = f"https://search.naver.com/search.naver?where=image&sm=tab_jum&query={search}"
    driver.get(url)
    driver.implicitly_wait(5)
    
    #3. img 태그 선택해서 src 값 가져오기
    img = driver.find_element(By.CSS_SELECTOR, "#main_pack > section > div.api_subject_bx._fe_image_tab_grid_root.ani_fadein > div > div > div.image_tile._fe_image_tab_grid > div:nth-child(1) > div > div > div > img")
    img_src = img.get_attribute("src")
    
    #4.크롬 창 닫기
    driver.quit()
    
    return img_src


# 2. FastAPI를 기반으로 한 app 생성
app= FastAPI()

# app ==controller와 유사한 역할
# app에다가 미들웨어를 끼우는 작업 진행 --> 정책을 좀 풀어주려고!
app.add_middleware(
    #동일출처정책과 관련한 미들웨어
    CORSMiddleware,
    # 접근을 허용할 출처 (==접근을 허용할 url)
    allow_origins = ["http://localhost:8090"],
    allow_methods = ["*"],
    allow_headers = ["*"],
    allow_credentials = True
    
)

# 3. 요청을 처리할 수 있는 url - 함수를 생성 
@app.get("/temp")
def temp(sendData):
    print("data:"+ sendData)
    img_src = crawling(sendData)
    return {"img_src" : img_src}
    


# In[ ]:
