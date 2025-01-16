<template>
  <article>
    <section id="article_header">
      <div class="ctn_subtitle">
          <div>// {{article.type}}</div>
          <div>{{ article.tags  }}</div>
      </div>
      <div id="ctn_article"><h1>{{article.title}}</h1></div>
      <div class="title_authorArtist">
        <p>Por <span>{{ article.authors }}</span></p>
        <p id="separator">//</p>
        <p>Arte <span>{{ article.artist }}</span></p>
      </div>
      <div id="coverImg">
        <img :src="'../src/assets/images/article/' + article.id + '/cover.jpg'" :alt="article.coverImg">
      </div>
      <div id="articleDate">
        <p>{{ article.date }}</p>
      </div>
    </section>
    <section id="contents">
      <summary id="summary">
        <p>{{ article.summary }}</p>
      </summary>
      <div id="content_body"></div>
      <div id="goToTop">
        <a href="#article_header"><img src="../assets/arrowUpIcon.svg" alt="">Ir arriba</a>
      </div>
    </section>
    <section id="share">
      <div>
        <div>
          <p>¿Te gustó este artículo?</p>
          <p>¡Compartilo!</p>
        </div>
        <div>
          <a href="https://twitter.com/home?lang=es"><img src="../assets/twitterIcon.svg" alt="Twitter" srcset=""></a>
          <a href="https://www.instagram.com/"><img src="../assets/instagramIcon.svg" alt="Instagram" srcset=""></a>
          <a href="https://www.facebook.com/?locale=es_LA"><img src="../assets/facebookIcon.svg" alt="Facebook" srcset=""></a>
        </div>
        <button @click="copyAdress()">Copiar Link</button>
      </div>
    </section>
    <section>
        <div class="ctn_subtitleSecondType">
          <div>
            <p> // Contenido relacionado</p>
          </div>
        </div>
        <div v-if="article.category">
          <ArticlePreview :amountProp="4" :filterProp="article.category"></ArticlePreview>
        </div>
    </section>
  </article>
</template>

<script setup lang="ts">
  import axios from 'axios';
  import ArticlePreview from '@/components/Article_Preview.vue';
  import type { IArticle } from '@/data/models';
  import { onBeforeMount, ref } from 'vue';

  import { dbUrl } from '@/assets/common'
  const apiBaseUrl = dbUrl();

  const article = ref<IArticle>()

  onBeforeMount(async() => {
    const articleId = window.location.pathname.split("/").pop();
    await axios.get(apiBaseUrl + 'getArticle-' + articleId)
      .then(response => {
        article.value = response.data[0];
        document.getElementById("content_body").innerHTML = article.value.body;
      }
    )
    .catch(function (error) {
      console.log(error);
    });
  })

  function copyAdress() {
    let link = window.location.href;
    navigator.clipboard.writeText(link);
  }
</script>

<style scoped>
@import '@/assets/styles/article.css';
</style>