# -*- coding: utf-8 -*-
"""
Created on Sun Nov 22 21:55:50 2020

@author: Jannik
"""


from github import Github

def pull_request(creds, title, body, head, base="master"):
    """
    This function creates a pull request on Github
    (KITmetricslab/covid19-forecast-hub-de).
    
    Parameters
    ----------
    creds : str
        Authentification credentials of github user.
    title : str
        Title of the PR on Github
    body : str
        Body of the PR on Github
    head : str
        Name of the head branch.
    base : str, optional
        Name of the base branch. The default is "master".

    Returns
    -------
    None.

    """
    
    g = Github(creds)
    repo = g.get_repo("KITmetricslab/covid19-forecast-hub-de")
    repo.create_pull(title=title, body=body, head=head, base=base)