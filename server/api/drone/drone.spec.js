'use strict';

var should = require('should');
var app = require('../../app');
var request = require('supertest');

describe('GET /api/drones', function() {
  it('should respond with JSON array', function(done) {
    request(app)
      .get('/api/drones')
      .expect(200)
      .expect('Content-Type', /json/)
      .end(function(err, res) {
        if (err) return done(err);
        res.body.should.be.instanceof(Array);
        done();
      });
  });
});
describe('GET /api/drones/ip/127.01.0.1', function() {
  it('should respond with JSON array', function(done) {
    request(app)
      .get('/api/drones/ip/127.01.0.1')
      .expect(200)
      .expect('Content-Type', /json/)
      .end(function(err, res) {
        if (err) return done(err);
        res.body.should.be.instanceof(Array);
        done();
      });
  });
});
