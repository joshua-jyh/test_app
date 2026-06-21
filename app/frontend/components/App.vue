<script setup>
import { onMounted, ref } from 'vue'

const count = ref(0)
const status = ref({ state: 'loading', environment: '讀取中…' })

onMounted(async () => {
  try {
    const response = await fetch('/api/status', {
      headers: { Accept: 'application/json' },
    })

    if (!response.ok) throw new Error(`HTTP ${response.status}`)

    status.value = await response.json()
  } catch (error) {
    status.value = {
      state: 'error',
      environment: '無法連線 Rails API',
      message: error.message,
    }
  }
})
</script>

<template>
  <main class="shell">
    <section class="card">
      <p class="eyebrow">Rails + Vue 測試專案</p>
      <h1>整合環境已就緒</h1>
      <p class="lead">
        Rails 提供頁面與 API，Vue 3 由 Vite 建置並掛載到同一個應用程式。
      </p>
      <p class="lead">
        您好＠♨♨♨♨，這裡是 Vue 前端組件，正在嘗試從 Rails API 讀取狀態資訊。
      </p>

      <dl class="status-grid">
        <div>
          <dt>Rails API</dt>
          <dd :class="`status-${status.state}`">{{ status.state }}</dd>
        </div>
        <div>
          <dt>執行環境</dt>
          <dd>{{ status.environment }}</dd>
        </div>
      </dl>

      <button type="button" @click="count += 1">
        Vue 計數測試：{{ count }}
      </button>
    </section>
  </main>
</template>
