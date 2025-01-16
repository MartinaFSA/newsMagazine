<template>
    <div id="ctn_artistas">
        <div id="artistsNamesArt">
            <div v-if="allArtists">
                <button v-for="(artist, index) in allArtists" :key="index" @click="selectArtist(artist)" :id="'artist_' + artist.id" :class="{'selectedArtist' : index === 0}">{{ artist.name }} / </button>
            </div>
            <img v-if="selectedArtist" :src="'../src/assets/images/artist/' + (selectedArtist.id || allArtists[0].id) + '.jpg'" :alt="'Ilustración de ' + selectedArtist.name">
        </div>
        <div id="artistInfo" v-if="selectedArtist">
            <div>
                <p class="mediumBlueText">{{selectedArtist.name}}</p>
                <p class="smallGrayText">{{selectedArtist.location}}</p>
                <p>{{selectedArtist.bio}}</p>
            </div>
                <RouterLink :to="'/collaborator/' + selectedArtist.id" alt="Ver todos los artículos ilustrados por el artista">Artículos ilustrados</RouterLink>
        </div>
    </div>
</template>

<script setup lang="ts">
    import { onBeforeMount, ref } from 'vue';
    import { dbUrl } from '@/assets/common'
    import axios from 'axios';
    const apiBaseUrl = dbUrl();
    import type { IArtist } from '@/data/models';

    const allArtists = ref<IArtist[]>()
    const selectedArtist = ref<IArtist>()

    onBeforeMount(async() => {
        await axios.get(apiBaseUrl + 'allArtists').then((response) =>     
            {
                allArtists.value = response.data
                selectedArtist.value = response.data[0]
                getSocials(response.data)
            }
        )
        .catch(function (error) {
            console.log(error);
        });
    })

    function getSocials(jsonData) {
        jsonData.forEach(person => {
            let cleanLinks = person.socialMedia.split('"');
            cleanLinks = cleanLinks.filter(name => name.includes('www.'))
            person.socialMedia = cleanLinks;
        });
    }

    function selectArtist(artist) {
        selectedArtist.value = artist;
        document.getElementsByClassName('selectedArtist')[0].classList.remove('selectedArtist');
        document.getElementById('artist_'+artist.id).classList.add('selectedArtist');
    }
</script>

<style scoped>

    /*ARTISTS*/
    #ctn_artistas {
        color: var(--mainColor);
        border: var(--borderStyleStroke);
    } #ctn_artistas > div:last-of-type{
        border-right: var(--borderStyleStroke);
    }
    #artistsNamesArt, #artistInfo {
        font-family: WorkSans-Regular;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    } #artistsNamesArt > div {
        width: 100%;
        margin-top: 40px;
    } #artistsNamesArt button {
        background-color: transparent;
        font-size: 1.1em;
        white-space: nowrap;
        border: none;
        cursor: pointer;
    } #artistsNamesArt img {
        width: 100%;
        height: 50%;
        object-fit: cover;
        filter: saturate(0);
        transition: filter 0.5s ease-in-out;
    } #artistsNamesArt img:hover {
        filter: saturate(1);
    } .selectedArtist {
        color: var(--accentColor);
    } #artistInfo p:first-of-type {
        margin-bottom: 0px;
    } #artistInfo p:nth-of-type(2) {
        margin-top: 5px;
    }


    @media screen and (max-width: 800px) {
        #ctn_artistas {
            padding:  0px var(--contentPadding);
        }
    }
    @media screen and (min-width: 801px) {
        #ctn_artistas {
            padding: 0px var(--pagePadding);
        } 
    }

    @media screen and (max-width: 900px) {
        #ctn_artistas > div {
            border-right: var(--borderStyleStroke);
            border-left: var(--borderStyleStroke);
        } #artistsNamesArt img {
            margin: 30px 0px;
        } #artistInfo > a {
            border-top: var(--borderStyleStroke);
            padding: 10px;
            text-align: center;
        } #ctn_artistas > div:first-of-type, #artistInfo > div:first-of-type {
            padding: 0px var(--contentPadding);
        } #artistInfo p:first-of-type {
            margin-top: 0px;
        }
    }
    @media screen and (min-width: 901px) {
        #ctn_artistas > div {
            width: 50%;
        } #ctn_artistas > div:last-of-type{
            border-right: var(--borderStyleStroke);
        }
        #ctn_artistas {
            display: flex;
            flex-direction: row;
        } #artistsNamesArt img, #artistInfo > a {
            margin-bottom: 40px;
        } #ctn_artistas > div {
            border-left: var(--borderStyleStroke);
            padding: 0px var(--contentPadding);
        } #artistInfo p:first-of-type {
            margin-top: 40px;
        }
    }
</style>