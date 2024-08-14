from langchain_core.tools import tool
import requests
import os
from pycragapi import CRAG

@tool
def search_knowledge_base(query: str) -> str:
    '''Search the knowledge base for a specific query.'''
    # use worker agent (DocGrader) to search the knowledge base
    url = os.environ.get('WORKER_AGENT_URL')
    proxies = {"http": ""}
    payload = {
        "query":query,
        } 
    response = requests.post(url, json=payload, proxies=proxies)
    return response.json()["text"]
    

@tool
def get_grammy_best_artist_by_year(year: int) -> dict:
    '''Get the Grammy Best New Artist for a specific year.'''
    api = CRAG()
    year = int(year)
    return api.music_grammy_get_best_artist_by_year(year)


@tool
def get_members(band_name: str) -> dict:
    '''Get the member list of a band.'''
    api = CRAG()
    return api.music_get_members(band_name)

@tool
def get_artist_birth_place(artist_name: str) -> dict:
    '''Get the birthplace of an artist.'''
    api = CRAG()
    return api.music_get_artist_birth_place(artist_name)

@tool
def get_billboard_rank_date(rank: int, date: str = None) -> dict:
    '''Get Billboard ranking for a specific rank and date.'''
    api = CRAG()
    rank = int(rank)
    return api.music_get_billboard_rank_date(rank, date)

@tool
def get_song_release_date(song_name: str) -> dict:
    '''Get the release date of a song.'''
    api = CRAG()
    return api.music_get_song_release_date(song_name)
