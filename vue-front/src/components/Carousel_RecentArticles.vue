<template>
  <section>
    <div class="ctn_recent">
      <div class="categories_name">
        <div v-for="(category, index) in allCategories" :key="index"><p>{{ category.category }}</p></div>
      </div>

      <!-- Generate a row for each category and add 5 articles in them -->
      <div class="ctn_categories carousel">
        <div 
          class="inner" 
          ref="innerRef" 
          :style="innerStyles" 
          v-for="(categoryRow, index) in recentFiveCategorized" 
          :key="index">
          <RouterLink 
            :to="'/article/' + toSlug(card.title)" 
            alt="Ir al artículo" 
            v-for="(card) in categoryRow" 
            :key="card.id" 
            class="category card">
            <div class="categoryMobile"><p>{{ card.category }}</p></div>
            <p>{{ card.title }}</p>
            <p>Por <span>{{ card.authors }}</span> // Arte <span>{{ card.artist }}</span></p>
          </RouterLink>
        </div>
      </div>
    </div>

    <!-- Carousel Controls -->
    <div class="carrousel_controls">
      <button @click="handleNavigation('prev')"><img src="@/assets/arrow-icon-left.svg" alt="Previous article"></button>
      <RouterLink to="/allArticles">Ver más</RouterLink>
      <button @click="handleNavigation('next')"><img src="@/assets/arrow-icon-right.svg" alt="Next article"></button>
    </div>
  </section>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick } from 'vue';
import { dbUrl, toSlug } from '@/assets/common';
import axios from 'axios';

// Declare refs for necessary variables
const recentFiveCategorized = ref<any[]>([]);
const allCategories = ref<any[]>([]);
const innerStyles = ref<any>({});
const step = ref('');
const transitioning = ref(false);

// Get the base URL for API requests
const apiBaseUrl = dbUrl();

// Fetch data on mount
onMounted(async () => {
  try {
    const [categorizedRes, categoriesRes] = await Promise.all([
      axios.get(apiBaseUrl + 'recentFiveCategorized'),
      axios.get(apiBaseUrl + 'allCategories')
    ]);
    
    recentFiveCategorized.value = divideCategoriesInRows(categorizedRes.data);
    console.log(categorizedRes.data)
    allCategories.value = categoriesRes.data;

    // After data load, calculate the width for the carousel step
    nextTick(setStep);
  } catch (error) {
    console.error('Error fetching data:', error);
  }
});

// Function to divide the categorized data into rows of 5 articles each
function divideCategoriesInRows(data: any[]) {
  const groupedByCategory: { [key: string]: any[] } = {};

  // Group articles by their category
  data.forEach(article => {
    if (!groupedByCategory[article.category]) {
      groupedByCategory[article.category] = [];
    }
    groupedByCategory[article.category].push(article);
  });

  // Now divide each category into rows of 5 articles
  const chunkedData = [];

  for (const category in groupedByCategory) {
    const categoryArticles = groupedByCategory[category];
    
    // Create chunks of 5 articles for each category
    for (let i = 0; i < categoryArticles.length; i += 5) {
      chunkedData.push(categoryArticles.slice(i, i + 5));
    }
  }

  return chunkedData;
}

// Create a ref for accessing inner divs
const innerRef = ref<HTMLElement | null>(null);

// Set the step based on the inner div width
function setStep() {
  const innerWidth = innerRef.value?.scrollWidth || 0;
  const totalCards = recentFiveCategorized.value.length;
  console.log('Inner Width:', innerWidth, 'Total Cards:', totalCards);  // Debug the width and card count
  step.value = `${innerWidth / totalCards}px`;
  console.log('Step value:', step.value);  // Log the calculated step
}

// Handle the carousel navigation (next or previous)
function handleNavigation(direction: 'next' | 'prev') {
  console.log('Navigation clicked: ', direction);  // Log the direction
  
  if (transitioning.value) {
    console.log('Transitioning in progress...');  // Check if transitioning is preventing action
    return;
  }

  transitioning.value = true;
  
  const action = direction === 'next' ? moveLeft : moveRight;
  const updateOrder = direction === 'next' ? moveNextOrder : movePrevOrder;

  action();
  afterTransition(() => {
    updateOrder();
    transitioning.value = false;
    console.log('Transition completed.');  // Log after the transition
  });
}

// Move the carousel to the left
function moveLeft() {
  innerStyles.value = { transform: `translateX(-${step.value})` };
}

// Move the carousel to the right
function moveRight() {
  innerStyles.value = { transform: `translateX(${step.value})` };
}

// Update the order of the articles for the "next" navigation
function moveNextOrder() {
  for (const categoryRow of recentFiveCategorized.value) {
    const article = categoryRow.shift();
    categoryRow.push(article);
  }
  resetTranslate();
}

// Update the order of the articles for the "previous" navigation
function movePrevOrder() {
  for (const categoryRow of recentFiveCategorized.value) {
    const article = categoryRow.pop();
    categoryRow.unshift(article);
  }
  resetTranslate();
}

// Reset the translation styles after transition
function resetTranslate() {
  innerStyles.value = { transition: 'none' };
}

// After the transition, trigger the callback
function afterTransition(callback: () => void) {
  const listener = () => {
    callback();
    console.log('Transition has ended');  // Log when transition ends
    for (const el of innerRef.value?.children || []) {
      el.removeEventListener('transitionend', listener);
    }
  };

  for (const el of innerRef.value?.children || []) {
    el.addEventListener('transitionend', listener);
  }
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