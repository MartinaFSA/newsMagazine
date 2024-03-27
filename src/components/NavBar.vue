<template>
  <header>
    <nav class="flexBetween">
        <div>
            <RouterLink to="/" aria-label="Ir al inicio"><img src="" alt="Ir al inicio"></RouterLink>
        </div>
        <div id="navLinks">
            <ul>
                <li class="navLink"><RouterLink to="/allArticles">Artículos</RouterLink></li>
                <li class="navLink"><RouterLink to="/collaborator">Colaboradores</RouterLink></li>
                <li class="navLink"><RouterLink to="/about">Sobre nosotros</RouterLink></li>
            </ul>
        </div>
    </nav>
  </header>
</template>

<script>

export default {

}
</script>

<style>

</style>