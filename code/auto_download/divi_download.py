# -*- coding: utf-8 -*-
"""
Created on Wed Jun 24 18:29:53 2020

@author: Jannik
"""

import os
from selenium import webdriver
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
from pathlib import Path

from urllib.parse import urljoin  # for Python2: from urlparse import urljoin
from urllib.request import urlretrieve

path = str(Path.cwd().parent.parent.joinpath("data-truth", "DIVI", "raw"))


url = "https://www.divi.de/divi-intensivregister-tagesreport-archiv-csv"
options = webdriver.ChromeOptions()
prefs = {'download.default_directory': path}
options.add_argument('--no-sandbox')
options.add_argument('--headless')
options.add_argument('--disable-dev-shm-usage')
options.add_argument('--disable-gpu')
options.add_experimental_option('prefs', prefs)
driver = webdriver.Chrome(ChromeDriverManager().install(),
                              chrome_options=options)
driver.get(url)

pagination = driver.find_element_by_css_selector("ul.pagination")
pages = pagination.find_elements(By.TAG_NAME, "li")

page_links = [url]

for page in pages:
    ele = page.find_elements(By.TAG_NAME, "a")[0]
    name = ele.text
    if name.isdigit():
        link = ele.get_attribute('href')
        if link:
            page_links.append(link)

csv_links = []

for link in page_links:

    driver.get(link)

    csv_table = driver.find_element_by_css_selector("table#table-document.table-condensed.table-document")
    csvs = csv_table.find_elements(By.CLASS_NAME, "edocman-document-title-td")

    for csv_link in csvs:
        csv_link = csv_link.find_elements(By.TAG_NAME, "a")[0]
        csv_name = csv_link.get_attribute('aria-label')
        csv_link = csv_link.get_attribute('href')
        csv_links.append((csv_link, csv_name))

for link in csv_links:

    base_name = link[1][:-6]
    base_name = base_name.replace("divi", "DIVI")

    # list of files
    csv_files = [f for f in os.listdir(path) if os.path.isfile(os.path.join(path, f))]

    if any(base_name in x for x in csv_files):
        continue
    else:
        download_link = link[0]
        file_name = "../../data-truth/DIVI/raw/" + base_name + ".csv"
        urlretrieve(download_link, file_name)
        print(base_name)
