<template>
  <h1 class="defaultH1Style">Todos los artículos</h1>
  <section>
    <div id="ctn_filter">
      <label for="category">Filtrar por categoría:</label>
      <select name="category" @change="selectedCategoryFilter=$event.target.value; forceRerender()">
        <option value="" selected>Todas</option>
        <option  v-for="(category, index) in allCategories" :key="index" :value="category.category">{{ category.category }}</option>
      </select>
    </div>
  </section>
  <section :key="componentKey">
    <ArticlePreview v-if="selectedCategoryFilter === ''" filterProp="all"></ArticlePreview>
    <ArticlePreview v-else :filterProp="selectedCategoryFilter"></ArticlePreview>
  </section>
</template>

<script setup lang="ts">
  import ArticlePreview from '@/components/Article_Preview.vue';
  import { onBeforeMount, ref } from 'vue';

  import { dbUrl } from '@/assets/composables/utils'
  import axios from 'axios';
  const apiBaseUrl = dbUrl();

  const allCategories = ref([])
  const selectedCategoryFilter = ref('')
  const componentKey = ref(0)

  onBeforeMount(async() => {

    //TEST FOR NODEJS API
    axios({
      method: 'get',
      url: 'http://localhost:3000',
      responseType: 'stream'
    })
    .then((response) => {
      console.log(response.data)
      //articles = response.data
      }
    )
    .catch((error)  => {
      console.log(error)
      //articles = response.data
      }
    )
    //FINISH TEST


    await axios.get(apiBaseUrl + 'allCategories')
      .then(response => (allCategories = response.data)
    )
    .catch(function (error) {
      console.log(error);
    });
  })
  function forceRerender() {
    componentKey.value += 1;
  }
</script>

<style scoped>
  #ctn_filter {
    margin-bottom: 30px;
    padding: 0% var(--pagePadding);
    display: flex;
    justify-content: flex-end;
  }
  label {
    color: var(--accentColor);
    font-size: 1rem;
    font-family: WorkSans-Regular;
    font-weight: 400;
  }
  select {
    font-family: WorkSans-Regular;
    font-size: 1rem;
    font-weight: 400;
    border: var(--borderStyleStroke);
    color: var(--mainColor);
    background-color: transparent;
    margin-left: var(--contentPadding);
  } option {
    background-color: var(--bodyBackground);
  }
  .defaultH1Style {
    margin: 50px var(--pagePadding);
    text-align: center;
  }

@media screen and (min-width: 801px) {
  .defaultH1Style {
    font-size: 4em;
  }
}
</style>