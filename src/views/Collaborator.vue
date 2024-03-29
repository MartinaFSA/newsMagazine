<template>
  <section>
    <div><p>{{this.writer.id}}</p></div>
  </section>
</template>

<script>
export default {
  data() {
    return {
      writerId: null,
      writer: []
    }
  },
  created() {
    axios.get('http://localhost/api/general.php/writer' + this.writerId)
        .then(response => (this.writer = response.data)
        )
        .catch(function (error) {
            console.log(error);
        });
    let writerId = window.location.pathname.split("/").pop();
    this.writerId = writerId;
  }
}
</script>

<style>

</style>