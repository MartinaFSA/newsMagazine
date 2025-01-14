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
        <Artists></Artists>
    </section>
  </main>
</template>

<script>
import axios from 'axios';
import CarouselRecent from '@/components/Carousel_RecentArticles.vue';
import CarouselWriters from '@/components/Carousel_Writers.vue';
import Artists from '@/components/Artists.vue';

export default {
    data() {
        return {
            outstandingArticles: []
        }
    },
    components: {
        CarouselRecent,
        CarouselWriters,
        Artists
    },
    async created() {
        let apiBaseUrl = "https://api-newsmagazine.000webhostapp.com/api/public/";
        await axios.get(apiBaseUrl + 'outstandingArticles.php/all')
            .then(response => (this.outstandingArticles = response.data)
            )
            .catch(function (error) {
                console.log(error);
            });
    }
}
</script>

<style scoped>
    @import '@/assets/styles/landingPage.css';
</style>