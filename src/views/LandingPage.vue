<template>
  <main>
    <section>
        <div class="ctn_subtitle">
            <div>// Destacados</div>
            <div>Escritos por el equipo de colaboradores</div>
        </div>
        <div id="ctn_outstandingArticle">
            <div v-for="(article, index) in this.outstandingArticles" :key="index" class="outstanding_article">
                <p class="tags">{{article.tags}}</p>
                <p class="title">{{article.title}}</p>
                <p class="authors">Por <span>{{article.authors}}</span></p>
                <div class="ctn_description"><p class="description">{{ article.summary}}</p></div>
                <div class="dateAndPlus flexBetween">
                    <p class="smallGrayText">{{article.date}}</p>
                    <RouterLink :to="'/article/' + article.id" alt="Ir al artículo" class="plusButton"><img src="@/assets/plus-icon.svg"></RouterLink>
                </div>
            </div>
        </div>
    </section>
    <section>
        <div class="ctn_subtitle">
            <div>// Recientes</div>
        </div>
        <CarouselRecent></CarouselRecent>
    </section>
    <section>
        <div class="ctn_subtitleSecondType">
            <div>
                <p> // Cronistas</p>
            </div>
        </div>
        <CarouselWriters></CarouselWriters>
    </section>
    <section>
        <div class="ctn_subtitleSecondType">
            <div>
                <p> // Artistas</p>
            </div>
        </div>
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
                    <RouterLink :to="'/filteredArticles/artist?' + this.selectedArtist.id" alt="Ver todos los artículos ilustrados por el artista">Artículos ilustrados</RouterLink>
            </div>
        </div>
    </section>
  </main>
</template>

<script>
import axios from 'axios';
import CarouselRecent from '@/components/Carousel_RecentArticles.vue';
import CarouselWriters from '@/components/Carousel_Writers.vue';

export default {
    data() {
        return {
            outstandingArticles: [],
            allArtists: [],
            selectedArtist: []
        }
    },
    components: {
        CarouselRecent,
        CarouselWriters
    },
    async created() {
        await axios.get('http://localhost/api/outstandingArticles.php/all')
            .then(response => (this.outstandingArticles = response.data)
            )
            .catch(function (error) {
                console.log(error);
            });
        await axios.get('http://localhost/api/general.php/allArtists')
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
@import '@/assets/styles/landingPage.css';

</style>