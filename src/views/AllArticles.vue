<template>
  <h1 class="defaultH1Style">Todos los artículos</h1>
  <section>
    <div id="ctn_filter">
      <label for="category">Filtrar por categoría:</label>
      <select name="category" @change="selectedCategoryFilter=$event.target.value; this.forceRerender()">
        <option value="" selected>Todas</option>
        <option  v-for="(category, index) in this.allCategories" :key="index" :value="category.category">{{ category.category }}</option>
      </select>
    </div>
  </section>
  <section :key="this.componentKey">
    <ArticlePreview v-if="this.selectedCategoryFilter === ''" filterProp="all"></ArticlePreview>
    <ArticlePreview v-else :filterProp="this.selectedCategoryFilter"></ArticlePreview>
  </section>
</template>

<script>
import ArticlePreview from '@/components/Article_Preview.vue';
export default {
  components: {
    ArticlePreview
  },
  data() {
    return {
      allCategories: [],
      selectedCategoryFilter: '',
      componentKey: 0
    }
  },
  async created() {
    let apiBaseUrl = "https://api-newsmagazine.000webhostapp.com/api/public/";
    await axios.get(apiBaseUrl + 'articles.php/allCategories')
      .then(response => (this.allCategories = response.data)
      )
      .catch(function (error) {
          console.log(error);
      });
  },
  methods: {
    forceRerender() {
      this.componentKey += 1;
    }
  }
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