'use strict'

const TurtleCoind = require('./')
const log = require('./log.js')
const env = process.env
const path = require('path')

let daemon = new TurtleCoind({
  path: '/usr/local/bin/TurtleCoind',
  dataDir: '~/turtlecoind/.TurtleCoin',
  loadCheckpoints: env.CHECKPOINTS_LOCATION + env.CHECKPOINTS_FILE || false,
  exclusiveNodes: env.ADD_EXCLUSIVE_NODE,
  peers: env.ADD_PEER || false,
  seedNode: env.SEED_NODE || false,
  priorityNodes: env.ADD_PRIORITY_NODE || false,
  allowLocalIp: env.ALLOW_LOCAL_IP || false,
  dbMaxOpenFiles: env.DB_MAX_OPEN_FILES || false,
  dbReadCacheSize: env.DB_READ_BUFFER_SIZE || false,
  dbThreads: env.DB_THREADS || false,
  dbWriteBufferSize: env.DB_WRITE_BUFFER_SIZE || false,
  enableBlockExplorer: env.ENABLE_BLOCKEXPLORER || true,
  enableCors: env.ENABLE_CORS || false,
  feeAddress: env.FEE_ADDRESS || false,
  feeAmount: env.FEE_AMOUNT || 0,
  hideMyPort: env.HIDE_MY_PORT || false,
  logFile: env.LOG_FILE || path.resolve(__dirname, './TurtleCoind.log'),
  logLevel: env.LOG_LEVEL || 2,
  p2pBindIp: env.P2P_BIND_IP || false,
  p2pBindPort: env.P2P_BIND_PORT || false,
  p2pExternalPort: parseInt(env.P2P_EXTERNAL_PORT) || false,
  rpcBindIp: env.RPC_BIND_IP || '0.0.0.0',
  rpcBindPort: parseInt(env.RPC_BIND_PORT) || 11898
})

daemon.on('start', (args) => {
  log.info(`TurtleCoind has started... ${args}`)
})

daemon.on('started', () => {
  log.info('TurtleCoind is attempting to synchronize with the network...')
})

daemon.on('syncing', (info) => {
  log.info(`TurtleCoind has syncronized ${info.height} out of ${info.network_height} blocks ${info.percent}%`)
})

daemon.on('synced', () => {
  log.info('TurtleCoind is synchronized with the network...')
})

daemon.on('ready', (info) => {
  log.info(`TurtleCoind is waiting for connections at ${info.height} @ ${info.difficulty} - ${info.globalHashRate} H/s`)
})

daemon.on('desync', (daemon, network, deviance) => {
  log.warn(`TurtleCoind is currently off the blockchain by ${deviance} blocks. Network: ${network} Daemon: ${daemon}`)
})

daemon.on('down', () => {
  log.warn('TurtleCoind is not responding... stopping process...')
  daemon.stop()
})

daemon.on('stopped', (exitcode) => {
  log.warn(`TurtleCoind has closed (exitcode: ${exitcode})... restarting process...`)
  daemon.start()
})

daemon.on('info', (info) => {
  log.info(info)
})

daemon.on('error', (err) => {
  log.error(err)
})

daemon.start()
