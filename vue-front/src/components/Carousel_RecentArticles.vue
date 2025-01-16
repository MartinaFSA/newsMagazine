<template>
    <section>
      <div class="ctn_recent">
        <div class="categories_name">
          <div v-for="(category, index) in allCategories" :key="index"><p>{{ category.category }}</p></div>
        </div>
        <!-- Generate a row for each category and add 5 articles in them -->
        <div class="ctn_categories carousel">
          <div class="inner" ref="innerRef" :style="innerStyles" v-for="(categoryRow, index) in recentFiveCategorized.length" :key="index">
            <RouterLink :to="'/article/' + card.id" alt="Ir al artículo" v-for="(card) in recentFiveCategorized[index]" :key="card.id" class="category card">
              <div class="categoryMobile"><p>{{ card.category }}</p></div>
              <p>{{ card.title }}</p>
              <p>Por <span>{{ card.authors }}</span> // Arte <span>{{ card.artist }}</span></p>
            </RouterLink>
          </div>
        </div>
      </div>
      <div class="carrousel_controls">
        <button @click="prev"><img src="@/assets/arrow-icon-left.svg" alt="Next article" srcset=""></button>
        <RouterLink to="/allArticles">Ver más</RouterLink>
        <button @click="next"><img src="@/assets/arrow-icon-right.svg" alt="Next article" srcset=""></button>
      </div>
    </section>
  </template>
  
  <script setup lang="ts">
  import { ref, onMounted } from 'vue';
  import { dbUrl } from '@/assets/common';
  import axios from 'axios';
  
  // Declare refs for the necessary variables
  const recentFiveCategorized = ref([]);
  const allCategories = ref([]);
  const innerStyles = ref({});
  const step = ref('');
  const transitioning = ref(false);
  
  // Get the base URL for API requests
  const apiBaseUrl = dbUrl();
  
  // Fetch data on mount
  onMounted(async () => {
    try {
      const responseCategorized = await axios.get(apiBaseUrl + 'recentFiveCategorized');
      recentFiveCategorized.value = divideCategoriesInRows(responseCategorized.data);
  
      const responseCategories = await axios.get(apiBaseUrl + 'allCategories');
      allCategories.value = responseCategories.data;
    } catch (error) {
      console.error(error);
    }
  });
  
  // Function to divide the categorized data into rows
  function divideCategoriesInRows(data) {
    let array = [];
    for (let i = 0; i < data.length; i += 5) {
      const chunk = data.slice(i, i + 5);
      array.push(chunk);
    }
    return array;
  }
  
  // Create a ref for accessing inner divs in Vue 3
  const innerRef = ref(null);
  
  // Set the step (width of one card) based on the inner div width
  function setStep() {
    const innerWidth = innerRef.value[0]?.scrollWidth || 0;
    const totalCards = recentFiveCategorized.value.length;
    step.value = `${innerWidth / totalCards}px`;
  }
  
  // Handle the next button functionality
  function next() {
    if (transitioning.value) return;
    transitioning.value = true;
    moveLeft();
    afterTransition(() => {
      for (let i = 0; i < recentFiveCategorized.value.length; i++) {
        const article = recentFiveCategorized.value[i].shift();
        recentFiveCategorized.value[i].push(article);
        resetTranslate();
        transitioning.value = false;
      }
    });
  }
  
  // Handle the previous button functionality
  function prev() {
    if (transitioning.value) return;
    transitioning.value = true;
    moveRight();
    afterTransition(() => {
      for (let i = 0; i < recentFiveCategorized.value.length; i++) {
        const article = recentFiveCategorized.value[i].pop();
        recentFiveCategorized.value[i].unshift(article);
        resetTranslate();
        transitioning.value = false;
      }
    });
  }
  
  // Apply a transform to move the carousel left
  function moveLeft() {
    innerStyles.value = {
      transform: `translateX(${step.value}) translateX(-${step.value})`
    };
  }
  
  // Apply a transform to move the carousel right
  function moveRight() {
    innerStyles.value = {
      transform: `translateX(${step.value}) translateX(-${step.value})`
    };
  }
  
  // After the transition, trigger a callback
  function afterTransition(callback) {
    const listener = () => {
      callback();
      for (let i = 0; i < recentFiveCategorized.value.length; i++) {
        innerRef.value[i].removeEventListener('transitionend', listener);
      }
    };
    for (let i = 0; i < recentFiveCategorized.value.length; i++) {
      innerRef.value[i].addEventListener('transitionend', listener);
    }
  }
  
  // Reset the translate styles to their initial state
  function resetTranslate() {
    innerStyles.value = {
      transition: 'none'
    };
  }
  </script>
  
  <style scoped>
  /*CAROUSEL*/
  .carousel {
    width: 100%;
    overflow: hidden;
  }
  .inner {
    transition: transform 0.1s; /* how much time should it pass before showing next article */
    white-space: nowrap;
    display: flex;
    flex-direction: row;
  }
  .card {
    width: 600px;
    display: inline-flex;
    border-right: var(--borderStyleStroke);
  }
  .inner:not(:last-of-type) {
    border-bottom: var(--borderStyleStroke);
  }
  .category {
    text-decoration: none;
  }
  .categories_name > div, .category {
    padding: 10px var(--contentPadding);
  }
  
  /*RECENT*/
  .ctn_recent {
    display: flex;
    outline: var(--borderStyleStroke);
  }
  .categories_name > div {
    font-family: WorkSans-Italic;
    text-transform: uppercase;
  }
  .categories_name p {
    margin: 0%;
  }
  .ctn_categories {
    outline: var(--borderStyleStroke);
  }
  .category {
    flex-direction: column;
    justify-content: center;
    background-color: var(--bodyBackground);
  }
  .category p {
    color: var(--mainColor);
  }
  .category > p:first-of-type {
    font-family: InstrumentSerif-Regular;
    font-size: 1.5em;
    margin: 0%;
  }
  .category > p:not(:first-of-type) {
    font-family: WorkSans-Italic;
    margin: 0%;
  }
  .category span {
    font-weight: 500;
  }
  .categories_name > div, .category {
    height: 85px;
  }
  
  @media screen and (max-width: 800px) {
    .category {
      position: relative;
    }
    .categories_name {
      display: none;
    }
    .categoryMobile {
      position: absolute;
      top: 0px;
      left: 0px;
      background-color: var(--secondaryColor);
    }
    .categoryMobile p {
      padding: 2px var(--contentPadding);
      margin: 0%;
      color: var(--bodyBackground);
      font-family: WorkSans-Italic;
    }
  }
  
  @media screen and (min-width: 801px) {
    /*RECENT*/
    .ctn_recent {
      padding-left: var(--pagePadding);
    }
    .categories_name {
      width: 600px;
      border-left: var(--borderStyleStroke);
    }
    .categories_name > div {
      display: flex;
      align-items: center;
      border-right: var(--borderStyleStroke);
    }
    .categories_name > div:not(:last-of-type) {
      border-bottom: var(--borderStyleStroke);
    }
    .categoryMobile {
      display: none;
    }
  }
  </style>  