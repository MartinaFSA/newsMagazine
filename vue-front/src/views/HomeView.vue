<template>
  <main>
    <section>
        <div class="ctn_subtitle">
            <div>// Destacados</div>
            <div>Escritos por el equipo de colaboradores</div>
        </div>
        <div id="ctn_outstandingArticle">
            <div v-for="(article, index) in outstandingarticles" :key="index" class="outstanding_article">
                <p class="tags">{{article.tags}}</p>
                <p class="title">{{article.title}}</p>
                <p class="authors">Por <span>{{article.authors}}</span></p>
                <div class="ctn_description"><p class="description">{{ article.summary}}</p></div>
                <div class="dateAndPlus flexBetween">
                    <p class="smallGrayText">{{article.date}}</p>
                    <RouterLink :to="'/article/' + toSlug(article.title)" alt="Ir al artículo" class="plusButton"><img src="@/assets/plus-icon.svg" alt=""></RouterLink>
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

<script setup lang="ts">
    import axios from 'axios';
    import CarouselRecent from '@/components/Carousel_RecentArticles.vue';
    import CarouselWriters from '@/components/Carousel_Writers.vue';
    import Artists from '@/components/Artists.vue';
    
    import { onBeforeMount, ref } from 'vue';
    import type { IArticle } from '@/data/models';

    import { dbUrl, toSlug } from '@/assets/common'
    const apiBaseUrl = dbUrl();
    const outstandingarticles = ref<IArticle[]>()

    onBeforeMount(async() => {
        await axios.get(apiBaseUrl + 'outstanding_articles')
            .then(response => {
                outstandingarticles.value = response.data;
            }
        )
        .catch(function (error) {
            console.log(error);
        });
    })

</script>

<style scoped>
    @import '@/assets/styles/landingPage.css';
</style>