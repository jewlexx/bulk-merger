import * as core from '@actions/core';
import * as gh from '@actions/github';

async function run(): Promise<void> {
  try {
    const token = core.getInput('repo-token', { required: true });
    const authors = core.getInput('authors');
    const title = core.getInput('title');

    const repoName = core.getState('github.repository');

    const [owner, repo] = repoName.split('/');

    const kit = gh.getOctokit(token);

    const { data: pullRequest } = await kit.rest.pulls.list({
      owner,
      repo,
    });
  } catch (err) {
    if (err instanceof Error) core.setFailed(err.message);
  }
}

run();
