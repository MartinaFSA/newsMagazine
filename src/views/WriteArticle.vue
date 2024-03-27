<template>
  <form>
      <label>Name</label>
      <input type="text" name="name" v-model="name">

      <label>Email</label>
      <input type="email" name="email" v-model="email">

      <label>Country</label>
      <input type="text" name="country" v-model="country">

      <label>City</label>
      <input type="text" name="city" v-model="city">

      <label>Job</label>
      <input type="text" name="job" v-model="job">

      <input type="button" @click="createArticle()" value="Add">
    </form>
</template>

<script>
export default {
    data() {
        return {
            name: '',
            email: '',
            country: '',
            city: '',
            job: ''
        }
    },
    methods: {
        createArticle() {
            console.log("Create article!");
            let formData = new FormData();
            console.log("name:", this.name);
            formData.append('name', this.name);
            formData.append('email', this.email);
            formData.append('city', this.city);
            formData.append('country', this.country);
            formData.append('job', this.job);

            var article = {};
            formData.forEach(function(value, key){
                article[key] = value;
            });

            axios({
                method: 'post',
                url: 'http://newsmagazine-api.000.pe/articles.php',
                data: formData,
                config: { headers: {'Content-Type': 'multipart/form-data' }}
            })
            .then(function (response) {
                //handle success
                console.log(response)
                app.articles.push(article)
                app.resetForm();
            })
            .catch(function (response) {
                //handle error
                console.log(response)
            });
        },
        resetForm() {
            this.name = '';
            this.email = '';
            this.country = '';
            this.city = '';
            this.job = '';
        }
    }

}
</script>

<style>

</style>