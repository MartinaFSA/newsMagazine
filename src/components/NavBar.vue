<template>
  <header>
    <nav role="navigation">
        <div id="logo">
            <RouterLink to="/" aria-label="Ir al inicio"><img src="@/assets/logo.svg" alt="Ir al inicio"></RouterLink>
        </div>
        <div id="navLinks_desktop">
            <ul>
              <li><RouterLink to="/profile">Perfil</RouterLink></li>
              <li><RouterLink to="/allArticles">Artículos</RouterLink></li>
              <li><RouterLink to="/allCollaborators">Colaboradores</RouterLink></li>
              <li><RouterLink to="/about">Sobre nosotros</RouterLink></li>
            </ul>
        </div>
        <div id="hamburger">
          <input type="checkbox" />
          <div>
            <span></span>
            <span></span>
            <span></span>
          </div>
          <ul id="navLinks_mobile">
            <li><RouterLink to="/profile">Perfil</RouterLink></li>
            <li><RouterLink to="/allArticles">Artículos</RouterLink></li>
            <li><RouterLink to="/allCollaborators">Colaboradores</RouterLink></li>
            <li><RouterLink to="/about">Sobre nosotros</RouterLink></li>
          </ul>
        </div>
    </nav>
  </header>
</template>

<style scoped>
  nav {
    border-bottom: var(--borderStyleStroke);
    margin: 0%;
    padding: 10px var(--pagePadding);
    font-family: WorkSans-Regular;
    font-weight: 400;
    text-transform: uppercase;
    position: fixed;
    top: 0;
    z-index: 10;
    width: 86vw;
    background-color: var(--bodyBackground);
  } button {
    background-color: transparent;
    border: none;
  } 
  
  a {
    color: var(--mainColor);
    text-decoration: none;
  }

  li a {
    transition: text-decoration 0.3s ease;
    position: relative;
  }
  
  li a::after {
    opacity: 1;
    transform: scale(0);
    transform-origin: center;
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 0.1em;
    margin: -0.3em 0;
    background-color: var(--accentColor);
    transition: opacity 300ms, transform 300ms;
  } li a:hover::after, li a:focus::after {
    transform: scale(1);
  }

  @media screen and (max-width: 800px) {
    #navLinks_desktop {
      display: none;
    }
    nav {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    #navLinks_mobile {
      position: fixed;
      width: 90vw;
      height: calc(100vh + 50px);
      margin: -5vh 0 0 -70vw;
      padding: unset var(--pagePadding);
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      background-color: var(--bodyBackground);
      list-style-type: none;
      -webkit-font-smoothing: antialiased;
      transform-origin: 0% 0%;
      transform: translate(200%, 0);
      transition: transform 0.5s cubic-bezier(0.77,0.2,0.05,1.0);
    } 
    #hamburger input:checked ~ ul {
      transform: none;
      border-left: var(--borderStyleStroke);
    } #logo img, #hamburger img {
      height: 4vh;
    } #hamburger {
      display: block;
      position: relative;
      z-index: 1;
    } #hamburger input{
      display: block;
      width: 40px;
      height: 32px;
      position: absolute;
      top: -7px;
      left: -5px;
      cursor: pointer;
      opacity: 0; 
      z-index: 2;
      -webkit-touch-callout: none;
    }
    #hamburger span {
      display: block;
      width: 33px;
      height: 4px;
      margin-bottom: 5px;
      position: relative;
      background: var(--mainColor);
      border-radius: 3px;
      z-index: 1;
      transform-origin: 4px 0px;
      transition: transform 0.5s cubic-bezier(0.77,0.2,0.05,1.0),
                  background 0.5s cubic-bezier(0.77,0.2,0.05,1.0),
                  opacity 0.55s ease;
    }
    #hamburger span:first-child {
      transform-origin: 0% 0%;
    } #hamburger span:nth-last-child(2) {
      transform-origin: 0% 100%;
    } #hamburger input:checked ~ div > span { /*TOGGLE FUNCTION*/
      opacity: 1;
      transform: rotate(45deg) translate(-4px, -4px);
      background: #232323;
    } #hamburger input:checked ~ div > span:nth-last-child(3) {
      opacity: 0;
      transform: rotate(0deg) scale(0.2, 0.2);
    } #hamburger input:checked ~ div > span:nth-last-child(2) {
      transform: rotate(-45deg) translate(-15px, 15px);
    }
    #navLinks_mobile li {
      padding: 5px 0px;
      margin: 5px 0px;
    }
    li a {
      transition: text-decoration 0.3s ease;
      display: block;
      position: relative;
    }
  }
  @media screen and (min-width: 801px) {
    nav {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    #navLinks_mobile, #hamburger {
      display: none;
    }
    #navLinks_desktop {
      display: flex;
      justify-content: right;
    } #navLinks_desktop li {
      display: inline;
      list-style-type: none;
      padding: 0;
    } #logo img {
      height: 3vh;
    }
  }
  
  @media screen and (min-width: 801px) and (max-width: 1050px) {
    #navLinks_desktop li {
      margin-left: 2vw;
    }
  }
  @media screen and (min-width: 1050px) {
    #navLinks_desktop li {
      margin-left: 5vw;
    }
  }
</style>