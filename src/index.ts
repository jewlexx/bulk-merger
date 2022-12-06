import * as core from '@actions/core';

async function run(): Promise<void> {
  try {
    const token = core.getInput('token', { required: true });
    const repo = core.getInput('repo', { required: true });
    const owner = core.getInput('owner', { required: true });
  } catch (err) {
    if (err instanceof Error) core.setFailed(err.message);
  }
}

run();
