<template>
  <section>
      <div class="ctn_subtitle">
          <div>// Destacados</div>
          <div id="collaboratorName">{{ this.writer.name }}</div>
      </div>
      <div class="ctn_writers">
        <div class="writerProfileCard">
          <div class="writerProfiles">
              <div>
                  <img :src="'../src/assets/images/profile/' + this.writer.id + '.jpg'" :alt="'Foto de ' + this.writer.name">
                  <p>{{this.writer.profession}}</p>
                  <p class="smallGrayText">{{this.writer.location}}</p>
              </div>
          </div>
        </div>
      </div>
      <div class="ctn_writers">
        <div class="writerBio" :id="'writerBio_' + index">
          <p>{{ this.writer.bio }}</p>
          <div>
            <p v-for="(social) in this.writer.socialMedia" :key="social">{{social}}</p>
          </div>
        </div>
      </div>
  </section>
  <section>
    <h1 class="defaultH1Style">Artículos en los que participó</h1>

  </section>
</template>

<script>
export default {
  data() {
    return {
      writer: []
    }
  },
  created() {
    let apiBaseUrl = "https://api-newsmagazine.000webhostapp.com/api/public/";
    let writerId = window.location.pathname.split("/").pop();
    axios.get(apiBaseUrl + 'general.php/writer/' + writerId)
        .then(response => {getSocials(response.data[0]); (this.writer = response.data[0]);}
        )
        .catch(function (error) {
            console.log(error);
        });

    function getSocials(writer) {
      let cleanLinks = writer.socialMedia.split('"');
      cleanLinks = cleanLinks.filter(name => name.includes('www.'))
      return writer.socialMedia = cleanLinks;
    }
  }
}
</script>

<style scoped>
.writerProfiles, .borders {
  border-right: var(--borderStyleStroke);
  border-left: var(--borderStyleStroke);
}
/*WRITERS*/
.ctn_writers:not(:last-of-type) {
  outline: var(--borderStyleStroke);
} .ctn_writers:last-of-type {
  border: var(--borderStyleStroke);
} 
.ctn_writers {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 0px;
  padding: 0px var(--pagePadding);
} .writerProfileCard {
  display: flex;
  flex-direction: row;
  align-items: center;
  outline: var(--borderStyleStroke);
  padding: 0px var(--pagePadding);
} .writerProfiles {
  text-wrap: nowrap;
  text-align: center;
  padding: 20px var(--contentPadding);
} .writerProfiles div > p:first-of-type{
  padding: 0px;
  margin: 10px 0px 0px;
  font-weight: 500;
  font-family: WorkSans-Regular;
  color: var(--mainColor);
} .writerProfiles div > p:last-of-type{
  padding: 0px;
  margin: 0px 0px 20px;
} .writerProfiles img {
  height: 337px;
  object-fit: cover;
  filter: saturate(0);
}
#collaboratorName {
  color: var(--accentColor);
  font-family: InstrumentSerif-Regular;
  font-size: 1.7em;
} .writerBio {
  text-wrap: wrap;
  background-color: var(--accentColor);
  padding: 0px var(--contentPadding);
  border-left: var(--borderStyleStroke);
  border-right: var(--borderStyleStroke);
  color: var(--bodyBackground);
  max-width: 800px;
} .writerBio a {
  color: var(--bodyBackground);
}


h1 {
  text-align: center;
  padding: 5px var(--contentPadding);
}

@media screen and (max-width: 450px) {
  h1 {
    font-size: 2em;
  }
} @media screen and (min-width: 451px) and (max-width: 800px) {
  h1 {
      font-size: 3em;
  }
}
@media screen and (min-width: 801px) {
  h1 {
    text-align: center;
    font-size: 3.5em;
  }
}

@media screen and (max-width: 360px) {  
.writerProfileCard {
    width: 90vw;
}
.writerProfiles img {
    width: 90vw;
    max-width: 310px;
}
}
@media screen and (min-width: 361px) {
  .writerProfileCard {
    width: 350px;
  }
  .writerProfiles img {
    width: 310px;
  }
}

</style>