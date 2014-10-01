# Instructions to run

1. Install [Vagrant][1].
2. Install [Chef-DK][2].
3. Install vagrant-omnibus & vagrant-berkshelf plugins.

   ```
   $ vagrant plugin install vagrant-omnibus
   $ vagrant plugin install vagrant-berkshelf
   ```

4. Run `vagrant up`
5. Login to mongo1 with `vagrant ssh mongo1`.
6. On mongo1, import the wikipedia data into MongoDB by running
   `nbs-wikipedia-importer`.
7. On mongo1, calculate the top 10 pages per language by running
   `nbs-wikipedia-reporter`.

The source for `nbs-wikipedia-*` is available in a [separate
repository][3].

# Viewing results

`nbs-wikipedia-reporter` writes its results back into MongoDB, one
collection per language code. So, to see the top 10 pages for English,
login to mongo1 as above, run `mongo wikipedia` to launch a MongoDB shell
and then run `db.top_pages_en.find()`.

# Notes / Thoughts

The current implementation runs on a single VM, which is suboptimal in
terms of being able to scale the system. I've spent some time trying to
get MongoDB replication going, but haven't quite gotten it nailed down
yet.

The plan going forward to get this onto multiple boxes would be as
follows:

1. Get MongoDB replication working, with mongo1 acting as the master and
   subsequent nodes acting as read-only replicas.

2. The import process would be unaffected, but all replicas would
   receive a complete copy of the data.

3. The reporter process could then spread its calculating queries across
   the replicas on a per-language basis. Options for implementation here
   include using the connection pooling built into mgo (the MongoDB driver
   for Go that I'm using), which supports replica sets or by putting the
   replicas behind HAProxy. The latter would be my preference for
   production use since it would allow for monitoring and removal of
   unhealthy replicas from the pool.

MongoDB is currently wide-open, so adding authentication would generally
be desirable in production. :)

[1]: https://www.vagrantup.com/downloads.html
[2]: https://downloads.getchef.com/chef-dk/
[3]: https://github.com/psi/nbs-wikipedia
