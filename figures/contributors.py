from jug import TaskGenerator
from collections import Counter
import pandas as pd
import git
import numpy as np
from scipy import stats
from os import chdir
NORM_NAMES = {
        'Michael Waskom': 'mwaskom',
        'Paulo Monteiro': 'montoias',
        'Paulo Ricardo Monteiro': 'montoias',
        'Paulo Ricardo Ribeiro Monteiro': 'montoias',
        'Luis Pedro Coelho': 'luispedro',
        'Luís Pedro Coelho': 'luispedro',
        'Celio Santos-Jr': 'celiosantosjr',
        'Celio Santos': 'celiosantosjr',
        'Hiram He': 'HiramHe',
        'Doug Hyatt': 'hyattpd',

        }

@TaskGenerator
def number_contributors(repo):
    r = git.Repo('repos/'+repo)
    authors = []
    queue = [r.head.commit]
    seen = set()
    while queue:
        c = queue.pop()
        if c.hexsha in seen:
            continue
        seen.add(c.hexsha)
        authors.append(c.author.name)
        queue.extend(c.parents)
    authors = [NORM_NAMES.get(a,a) for a in authors]
    return pd.Series(Counter(authors)).sort_values(ascending=False)


@TaskGenerator
def effective_contributors(ac):
    return len(ac), np.exp(stats.entropy(ac.values))

REPOS = [
    'macrel',
    'jug',
    'seaborn',
    'megahit',
    'cpython',
    'scikit-bio',
    'scikit-learn',
    'SemiBin',
    'mahotas',
    'ngless',
    'Prodigal',
    ]

results = {}
for r in REPOS:
    ac = number_contributors(r)
    results[r] = effective_contributors(ac)
