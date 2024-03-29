<template>
  <section>
        <div class="ctn_subtitle">
            <div>// Recientes</div>
        </div>
        <div class="ctn_recent">
            <div class="categories_name">
                <div v-for="(category, index) in this.allCategories" :key="index"><p>{{ category.category }}</p></div>
            </div>
            <!--Generate a row for each category and add 5 articles in them-->
            <div class="ctn_categories carousel">
                <div class="inner" ref="inner" :style="innerStyles" v-for="(categoryRow, index) in recentFiveCategorized.length"  :key="index">
                    <div v-for="(card) in recentFiveCategorized[index]" :key="card.id" class="category card">
                        <div class="categoryMobile"><p>{{card.category}}</p></div>
                        <p>{{ card.title }}</p>
                        <p>Por <span>{{card.authors}}</span> // Arte <span>{{ card.artist }}</span></p>
                    </div>
                </div>
            </div>
        </div>
        <div class="carrousel_controls">
            <p>VER MÁS</p>
            <button @click="prev">prev</button>
            <button @click="next">next</button>
        </div>
    </section>
</template>

<script>
export default {

}
</script>

<style scoped>


</style>