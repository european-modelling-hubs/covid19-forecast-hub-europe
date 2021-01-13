import git
import pandas as pd

repo = git.Repo("../../")
tree = repo.tree()

commit_dates = pd.DataFrame(columns=['filename', 'first_commit', 'latest_commit'])

for blob in tree.traverse():
    if (blob.path.startswith('data-processed') & blob.path.endswith('.csv')):
        commits = list(repo.iter_commits(paths=blob.path))
        commit_dates.loc[len(commit_dates)] = [blob.path.split("/")[-1], # filename
                                               str(pd.to_datetime(commits[-1].committed_date, unit='s').date()), # first commit
                                               str(pd.to_datetime(commits[0].committed_date, unit='s').date())] # latest commit
        
commit_dates.to_csv('commit_dates.csv', index=False)
