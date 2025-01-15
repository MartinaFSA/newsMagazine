<template>
    <div id="ctn_artistas">
        <div id="artistsNamesArt">
            <div>
                <button v-for="(artist, index) in this.allArtists" :key="index" @click="this.selectArtist(artist)" :id="'artist_' + artist.id" :class="{'selectedArtist' : index === 0}">{{ artist.name }} / </button>
            </div>
            <img :src="'../src/assets/images/artist/' + this.selectedArtist.id + '.jpg'" :alt="'Ilustración de ' + this.selectedArtist.name">
        </div>
        <div id="artistInfo">
            <div>
                <p class="mediumBlueText">{{this.selectedArtist.name}}</p>
                <p class="smallGrayText">{{this.selectedArtist.location}}</p>
                <p>{{this.selectedArtist.bio}}</p>
            </div>
                <RouterLink :to="'/collaborator/' + this.selectedArtist.id" alt="Ver todos los artículos ilustrados por el artista">Artículos ilustrados</RouterLink>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            allArtists: [],
            selectedArtist: []
        }
    },
    async created() {
        let apiBaseUrl = "https://api-newsmagazine.000webhostapp.com/api/public/";
        await axios.get(apiBaseUrl + 'general.php/allArtists')
            .then(response => {
                this.allArtists = response.data;
                this.selectedArtist = response.data[0];
                getSocials(this.allArtists)
            })
            .catch(function (error) {
                console.log(error);
            });
        
        function getSocials(jsonData) {
            jsonData.forEach(person => {
                let cleanLinks = person.socialMedia.split('"');
                cleanLinks = cleanLinks.filter(name => name.includes('www.'))
                person.socialMedia = cleanLinks;
            });
        }
    },
    methods: {
        selectArtist(artist) {
            this.selectedArtist = artist;
            document.getElementsByClassName('selectedArtist')[0].classList.remove('selectedArtist');
            document.getElementById('artist_'+artist.id).classList.add('selectedArtist');
        }
    }
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
        text-wrap: nowrap;
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