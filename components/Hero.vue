<template>
  <div class="hero"> 
    <div class="avatar">
      <!-- <div class="avatar-cyan"></div> -->
      <!-- <div class="avatar-yello"></div> -->
      <!-- <div class="avatar-magenta"></div> -->
      <!-- <img src="../assets/img/Bello_crop.jpg" alt=""> -->
    </div>
    <Title />
    <!-- <img src="https://images.unsplash.com/photo-1524439188326-e47322d1cef2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80" alt=""> -->
  </div>
</template>

<script>
export default {
  name: 'Hero',

}
</script>

<style lang="scss" scoped>
.hero {
  height: 400px;
  position: relative;
  @media (min-width: 750px) {
    height: 100vh;
  }
  
  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
}

.avatar {
  z-index: 1;
  position: absolute;
  top: 8vh;
  // border: 10px solid magenta;
  right: 8vw;
  width: 30vw;
  .avatar-cyan{
    width: 30vw;
    height: 100%;
    background-color: cyan;
    position: absolute;
    top: 20px;
    right: 20px;
    z-index: -1;
    }
  .avatar-yello{
    width: 30vw;
    height: 100%;
    background-color: yellow;
    position: absolute;
    top: -15px;
    right: 10px;
    z-index: -2;
    }
  .avatar-magenta{
    width: 30vw;
    height: 100%;
    background-color: magenta;
    position: absolute;
    top: 30px;
    right: -20px;
    z-index: -3;
    }
  img {
    width: 100%;
    height: auto;
    z-index: 3;
  }
  
}
</style>