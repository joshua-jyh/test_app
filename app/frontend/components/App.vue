<script setup>
import { onMounted, ref } from 'vue'

const count = ref(0)
const status = ref({ state: 'loading', environment: '讀取中…' })
const demoData = ref({ users: [], posts: [] })
const dataState = ref('loading')
const dataError = ref('')

const loadData = async () => {
  dataState.value = 'loading'
  dataError.value = ''

  try {
    const [statusResponse, dataResponse] = await Promise.all([
      fetch('/api/status', { headers: { Accept: 'application/json' } }),
      fetch('/api/demo_data', { headers: { Accept: 'application/json' } }),
    ])

    if (!statusResponse.ok) throw new Error(`狀態 API：HTTP ${statusResponse.status}`)
    if (!dataResponse.ok) throw new Error(`資料 API：HTTP ${dataResponse.status}`)

    status.value = await statusResponse.json()
    demoData.value = await dataResponse.json()
    dataState.value = 'ok'
  } catch (error) {
    status.value = {
      state: 'error',
      environment: '無法連線 Rails API',
      message: error.message,
    }
    dataState.value = 'error'
    dataError.value = error.message
  }
}

const formatTime = (value) => {
  if (!value) return '—'

  return new Intl.DateTimeFormat('zh-TW', {
    dateStyle: 'short',
    timeStyle: 'medium',
  }).format(new Date(value))
}

onMounted(() => {
  loadData()
})
</script>

<template>
  <main class="shell">
    <div class="dashboard">
      <section class="card intro-card">
        <p class="eyebrow">Rails + Vue 測試專案</p>
        <h1>整合環境已就緒</h1>
        <p class="lead">
          Rails 提供頁面與 API，Vue 3 由 Vite 建置並掛載到同一個應用程式。
        </p>
        <p class="lead">
          您好＠♨♨♨♨，這裡是 Vue 前端組件，正在嘗試從 Rails API 讀取狀態資訊。
        </p>
        <p class="lead">
          OOO::::SSSSSSSSSSSSSSSSSSSS:::::OOO
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

      <section class="card data-card">
        <div class="data-heading">
          <div>
            <p class="eyebrow">Database</p>
            <h2>資料庫內容</h2>
          </div>
          <button class="secondary-button" type="button" :disabled="dataState === 'loading'" @click="loadData">
            {{ dataState === 'loading' ? '讀取中…' : '重新讀取' }}
          </button>
        </div>

        <p v-if="dataState === 'error'" class="data-error">{{ dataError }}</p>

        <template v-else>
          <section class="data-section">
            <h3>Users <span>{{ demoData.users.length }}</span></h3>
            <div class="table-wrap">
              <table>
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>名稱</th>
                    <th>Email</th>
                    <th>角色</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="user in demoData.users" :key="user.id">
                    <td>{{ user.id }}</td>
                    <td>{{ user.name }}</td>
                    <td>{{ user.email }}</td>
                    <td><span class="badge">{{ user.role }}</span></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </section>

          <section class="data-section">
            <h3>Posts <span>{{ demoData.posts.length }}</span></h3>
            <div class="post-list">
              <article v-for="post in demoData.posts" :key="post.id" class="post-item">
                <div class="post-meta">
                  <span>#{{ post.id }} · {{ post.author }}</span>
                  <span :class="post.published ? 'published' : 'draft'">
                    {{ post.published ? '已發布' : '草稿' }}
                  </span>
                </div>
                <h4>{{ post.title }}</h4>
                <p>{{ post.body }}</p>
                <time :datetime="post.updated_at">更新：{{ formatTime(post.updated_at) }}</time>
              </article>
            </div>
          </section>
        </template>
      </section>
    </div>
  </main>
</template>
