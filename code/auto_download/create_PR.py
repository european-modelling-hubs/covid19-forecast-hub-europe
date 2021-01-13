# -*- coding: utf-8 -*-
"""
Created on Mon Nov 30 14:51:39 2020

@author: Jannik
"""


from github_helper import *
import sys
import os

if __name__ == "__main__":
    
    creds = os.environ['AUTH']
    base = "master"
    title = sys.argv[1]
    body =  "This PR was created by Github actions"
    head = sys.argv[2]
    
    pull_request(creds, title, body, head, base)
