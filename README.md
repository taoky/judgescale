# Judgescale

A test necessary for large contests which uses a single server, multiple instances pattern of judgehost deployment.

Modified from domjudge/judge.

## How to test?

0. Reboot to get a clean kernel state.
1. Run createcgroups.sh to create domjudge cgroups.
2. `make`
3. Adjust `TASKS` in run.py.
4. `python run.py`, wait and see load, process states and judgescale output.
5. After test you could run `clean.sh` to clean created domjudge subcgroups (domjudge cgroup itself will NOT be removed).
