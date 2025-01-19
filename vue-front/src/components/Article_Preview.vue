<template>
  <section v-if="articles[0]" id="ctn_articlesPreview">
    <RouterLink v-for="(n, index) in defineAmountValue()" :key="index" :to="'/article/' + toSlug(articles[index].title)" class="article_Preview" alt="Ir al artículo">
        <img :src="'../src/assets/images/article/' + articles[index].id + '/cover.jpg'" :alt="articles[index].coverImg">
        <div>
          <p class="tags">{{articles[index].tags}}</p>
          <p class="title">{{articles[index].title}}</p>
        </div>
    </RouterLink>
  </section>
</template>

<script setup lang="ts">
import axios from 'axios';
import type { IArticle } from '@/data/models';
import { onBeforeMount, ref } from 'vue';

import { dbUrl, toSlug } from '@/assets/common'
const apiBaseUrl = dbUrl();

const articles = ref<IArticle[]>()

const props = defineProps({
  amountProp: {
    type: Number,
    required: false,
  },
  filterProp: {
    type: String,
    required: false,
    default: 'all'
  }
});

function defineAmountValue () {
  return props.amountProp ? props.amountProp : articles.value.length; //If amountProp is empty show all articles by default 
}
onBeforeMount(async() => {
    if (props.filterProp === 'all') {
      await axios.get(apiBaseUrl + 'articles_active')
        .then(response => 
          (articles.value = response.data)
        )
        .catch(function (error) {
            console.log(error);
        });
    } else {
      await axios.get(apiBaseUrl + 'articlesByCategory-' + props.filterProp)
        .then(response => 
          (articles.value = response.data)
        )
        .catch(function (error) {
            console.log(error);
        });
    }
})
</script>

<style scoped>
  #ctn_articlesPreview {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: space-evenly;
    border-bottom: var(--borderStyleStroke);
    border-top: var(--borderStyleStroke);
  }
  .article_Preview {
    width: 350px;
    margin-bottom: 10px;
    text-decoration: none;
    padding: 0px 10px;
  }
  .article_Preview img {
    width: 100%;
    height: 150px;
    object-fit: cover;
    filter: saturate(0);
  }
  .article_Preview div {
    padding: 20px;
    border-top: var(--borderStyleStroke);
  }
  .tags {
    color: var(--accentColor);
    font-family: WorkSans-Regular;
    font-size: 0.8em;
    margin: 0px 0px 5px 0px;
  }
  .title {
    color: var(--mainColor);
    font-family: InstrumentSerif-Regular;
    font-size: 1.3em;
    margin: 0%;
  }
</style>