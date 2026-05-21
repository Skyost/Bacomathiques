<script setup lang="ts">
import { site } from '~/site/site'

interface CommitSha {
  long: string
  short: string
}

const { data } = useLazyAsyncData<CommitSha>(
  'current-commit-sha',
  () => queryCollection('latestCommit')
    .first()
)

const githubRepo = `https://github.com/${site.github.username}/${site.github.repository}`
</script>

<template>
  <span v-if="data">Révision <a :href="`${githubRepo}/commit/${data.long}`">&#35;{{ data.short }}</a>.</span>
</template>
