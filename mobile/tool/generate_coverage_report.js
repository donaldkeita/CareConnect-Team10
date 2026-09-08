const fs = require('fs');
const path = require('path');

const projectRoot = path.resolve(__dirname, '..');
const lcovPath = path.join(projectRoot, 'coverage', 'lcov.info');
const outputDirectory = path.join(projectRoot, 'coverage', 'html');
const outputPath = path.join(outputDirectory, 'index.html');
const lcov = fs.readFileSync(lcovPath, 'utf8');
const records = lcov.split('end_of_record').map((record) => record.trim()).filter(Boolean);

const files = records.map((record) => {
  const sourceFile = record.match(/^SF:(.+)$/m)?.[1] ?? 'Unknown';
  const linesFound = Number(record.match(/^LF:(\d+)$/m)?.[1] ?? 0);
  const linesHit = Number(record.match(/^LH:(\d+)$/m)?.[1] ?? 0);
  const percentage = linesFound === 0 ? 100 : (linesHit / linesFound) * 100;
  return { sourceFile, linesFound, linesHit, percentage };
});

const totals = files.reduce((result, file) => ({
  linesFound: result.linesFound + file.linesFound,
  linesHit: result.linesHit + file.linesHit,
}), { linesFound: 0, linesHit: 0 });
totals.percentage = totals.linesFound === 0 ? 100 : (totals.linesHit / totals.linesFound) * 100;

const escapeHtml = (value) => value
  .replaceAll('&', '&amp;')
  .replaceAll('<', '&lt;')
  .replaceAll('>', '&gt;')
  .replaceAll('"', '&quot;');
const formatPercentage = (value) => `${value.toFixed(1)}%`;
const statusClass = (value) => value >= 80 ? 'good' : value >= 50 ? 'warning' : 'low';
const rows = files.map((file) => `
  <tr>
    <td><code>${escapeHtml(file.sourceFile)}</code></td>
    <td>${file.linesHit} / ${file.linesFound}</td>
    <td><span class="${statusClass(file.percentage)}">${formatPercentage(file.percentage)}</span></td>
  </tr>`).join('');

const html = `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>CareConnect Flutter Coverage</title>
<style>
  :root { color-scheme: light; font-family: system-ui, sans-serif; }
  body { margin: 0; background: #f5f7fb; color: #1d2939; }
  main { max-width: 960px; margin: 0 auto; padding: 48px 24px; }
  h1 { margin: 0 0 8px; color: #24466f; }
  .muted { color: #667085; }
  .summary { display: flex; gap: 16px; flex-wrap: wrap; margin: 28px 0; }
  .metric { background: white; border: 1px solid #dbe3ef; border-radius: 10px; padding: 20px; min-width: 170px; }
  .metric strong { display: block; font-size: 30px; margin-top: 6px; }
  table { width: 100%; border-collapse: collapse; background: white; border: 1px solid #dbe3ef; border-radius: 10px; overflow: hidden; }
  th, td { padding: 14px 16px; text-align: left; border-bottom: 1px solid #edf1f6; }
  th { background: #eef4fb; color: #24466f; }
  tr:last-child td { border-bottom: 0; }
  .good, .warning, .low { font-weight: 700; }
  .good { color: #087443; } .warning { color: #ad6200; } .low { color: #b42318; }
</style>
</head>
<body>
<main>
  <h1>CareConnect Flutter Coverage</h1>
  <p class="muted">Generated from <code>coverage/lcov.info</code>.</p>
  <section class="summary" aria-label="Coverage summary">
    <div class="metric">Line coverage<strong class="${statusClass(totals.percentage)}">${formatPercentage(totals.percentage)}</strong></div>
    <div class="metric">Lines hit<strong>${totals.linesHit}</strong></div>
    <div class="metric">Lines found<strong>${totals.linesFound}</strong></div>
    <div class="metric">Files<strong>${files.length}</strong></div>
  </section>
  <table>
    <thead><tr><th>Source file</th><th>Lines hit</th><th>Coverage</th></tr></thead>
    <tbody>${rows}</tbody>
  </table>
</main>
</body>
</html>`;

fs.mkdirSync(outputDirectory, { recursive: true });
fs.writeFileSync(outputPath, html);
console.log(`Wrote ${outputPath}`);
