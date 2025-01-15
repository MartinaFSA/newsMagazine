<template>
  <h1 class="defaultH1Style">Todos los colaboradores</h1>
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
</template>

<script>
import CarouselWriters from '@/components/Carousel_Writers.vue';
import Artists from '@/components/Artists.vue';
export default {
  components: {
      CarouselWriters,
      Artists
  },

}
</script>

<style scoped>
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